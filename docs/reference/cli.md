# CLI Reference

## Command

```bash
portwho <port>
portwho --kill <port>
portwho --help
```

## Dependencies

- `ss` (preferred, from `iproute2`)
- `lsof` (fallback)

## Environment variables

- `PORTWHO_ASSUME_YES=1`: auto-confirm kill prompt (use for automation/tests)
- `PORTWHO_KILL_CMD=/path/to/cmd`: override kill command (mainly for testing)
