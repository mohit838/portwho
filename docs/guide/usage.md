# Usage

## Show process by port

```bash
portwho 3000
```

## Kill mode (with confirmation)

```bash
portwho --kill 3000
```

## Help

```bash
portwho --help
```

## Exit codes

- `0`: success
- `1`: kill mode could not safely resolve PID
- `2`: invalid usage or invalid port
