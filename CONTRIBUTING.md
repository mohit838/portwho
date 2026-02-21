# Contributing

Thanks for contributing to `portwho`.

## Setup

```bash
git clone https://github.com/mohit838/portwho.git
cd portwho
bash tests/test_portwho.sh
```

## Development rules

- Keep scripts safe and predictable.
- Preserve `set -euo pipefail` in executable scripts.
- Add tests for behavior changes.
- Update docs when behavior changes.

## Pull request checklist

- Problem statement is clear.
- Fix is minimal and focused.
- `bash tests/test_portwho.sh` passes.
- Docs are updated if needed.
