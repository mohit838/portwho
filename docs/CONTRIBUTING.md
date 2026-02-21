# Contributing

## Setup

```bash
git clone https://github.com/<your-org>/portwho.git
cd portwho
bash tests/test_portwho.sh
```

## Rules

- Keep scripts POSIX-friendly where possible, but Bash is the runtime.
- Preserve `set -euo pipefail` in executable scripts.
- Add or update tests for behavior changes.
- Keep output clear and safe for production use.

## Pull Requests

- Explain the problem and the fix.
- Include test evidence (`bash tests/test_portwho.sh` output).
- Keep changes focused.
