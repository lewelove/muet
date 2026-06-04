# `mute album build`

rust passes the `MUTE_ORIGIN_PATHS` env var for each unique `sourceTorrent` found containing json string like

```jsonc
{
  "sourceTorrent.name": "/absolute/path/to/origin/resolved/source";
  // etc...
}
```

then nix resolves the actual system path by the value
