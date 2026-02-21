#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SCRIPT="$ROOT_DIR/bin/portwho"

pass_count=0
fail_count=0

pass() {
  pass_count=$((pass_count + 1))
  echo "PASS: $1"
}

fail() {
  fail_count=$((fail_count + 1))
  echo "FAIL: $1"
}

assert_contains() {
  local haystack="$1"
  local needle="$2"
  local name="$3"
  if [[ "$haystack" == *"$needle"* ]]; then
    pass "$name"
  else
    fail "$name"
    echo "  expected to find: $needle"
    echo "  got: $haystack"
  fi
}

assert_eq() {
  local expected="$1"
  local actual="$2"
  local name="$3"
  if [[ "$expected" == "$actual" ]]; then
    pass "$name"
  else
    fail "$name"
    echo "  expected: $expected"
    echo "  actual:   $actual"
  fi
}

make_mock_bin() {
  local dir="$1"
  mkdir -p "$dir"

  cat > "$dir/ss" <<'MOCK'
#!/usr/bin/env bash
printf "%s\n" "${MOCK_SS_OUT:-}"
MOCK

  cat > "$dir/lsof" <<'MOCK'
#!/usr/bin/env bash
printf "%s\n" "${MOCK_LSOF_OUT:-}"
MOCK

  cat > "$dir/kill" <<'MOCK'
#!/usr/bin/env bash
echo "$*" >> "${MOCK_KILL_LOG}"
MOCK

  chmod +x "$dir/ss" "$dir/lsof" "$dir/kill"
}

run_test_help() {
  local out
  out="$($SCRIPT --help)"
  assert_contains "$out" "Usage:" "help shows usage"
}

run_test_invalid_port() {
  set +e
  local out
  out="$($SCRIPT abc 2>&1)"
  local rc=$?
  set -e
  assert_eq "2" "$rc" "invalid port exits 2"
  assert_contains "$out" "invalid port" "invalid port error text"
}

run_test_ss_exact_port_match() {
  local tmp
  tmp="$(mktemp -d)"
  make_mock_bin "$tmp/bin"

  export MOCK_SS_OUT=$'tcp LISTEN 0 128 127.0.0.1:3000 0.0.0.0:* users:(("node",pid=111,fd=20))\ntcp LISTEN 0 128 127.0.0.1:13000 0.0.0.0:* users:(("python",pid=222,fd=3))'

  local out
  out="$(PATH="$tmp/bin:$PATH" $SCRIPT 3000)"

  assert_contains "$out" "port 3000" "ss reports selected port"
  assert_contains "$out" "pid=111" "ss keeps matching port line"
  if [[ "$out" == *"pid=222"* ]]; then
    fail "ss excludes non-matching port"
  else
    pass "ss excludes non-matching port"
  fi

  rm -rf "$tmp"
}

run_test_lsof_fallback_when_ss_missing() {
  local tmp
  tmp="$(mktemp -d)"
  mkdir -p "$tmp/bin"

  cat > "$tmp/bin/lsof" <<'MOCK'
#!/usr/bin/env bash
cat <<'OUT'
COMMAND   PID USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
python3  4321 me    3u  IPv4  12345      0t0  TCP 127.0.0.1:5050 (LISTEN)
OUT
MOCK
  chmod +x "$tmp/bin/lsof"

  local out
  out="$(PATH="$tmp/bin:/usr/bin:/bin" $SCRIPT 5050)"

  assert_contains "$out" "python3" "lsof fallback works"

  rm -rf "$tmp"
}

run_test_kill_mode_from_ss() {
  local tmp
  tmp="$(mktemp -d)"
  make_mock_bin "$tmp/bin"

  export MOCK_SS_OUT=$'tcp LISTEN 0 128 *:9000 *:* users:(("node",pid=111,fd=20),("node",pid=222,fd=21))'
  export MOCK_KILL_LOG="$tmp/kill.log"

  PORTWHO_ASSUME_YES=1 PORTWHO_KILL_CMD="$tmp/bin/kill" PATH="$tmp/bin:$PATH" "$SCRIPT" --kill 9000 >/tmp/portwho-test-kill.out

  local call
  call="$(cat "$tmp/kill.log")"
  assert_eq "-TERM 111 222" "$call" "kill sends SIGTERM to parsed pids"

  rm -rf "$tmp"
}

run_test_kill_mode_without_pid_fails() {
  local tmp
  tmp="$(mktemp -d)"
  make_mock_bin "$tmp/bin"
  export MOCK_SS_OUT=$'tcp LISTEN 0 128 *:7777 *:*'

  set +e
  PATH="$tmp/bin:$PATH" PORTWHO_ASSUME_YES=1 "$SCRIPT" --kill 7777 >/tmp/portwho-test-no-pid.out 2>&1
  local rc=$?
  set -e

  assert_eq "1" "$rc" "kill mode fails when pid missing"
  rm -rf "$tmp"
}

run_test_help
run_test_invalid_port
run_test_ss_exact_port_match
run_test_lsof_fallback_when_ss_missing
run_test_kill_mode_from_ss
run_test_kill_mode_without_pid_fails

echo
echo "Summary: $pass_count passed, $fail_count failed"
if (( fail_count > 0 )); then
  exit 1
fi
