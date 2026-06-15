# `mute album fetch source`

this command is used to read `album.nix`, identify `sourceTorrent {}` blocks and run `config.album.commands.sourceTorrent.fetch.<NAME>.package` against data contained in them

## FLAGS

### `--all` / `-a`

this flag is used to id all `sourceTorrent {}` blocks contained in them. if zero flags provided this is the flag that is used

### `--source-torrent-name` / `--stn`

this flag is used to selectively run fetch against `sourceTorrent {}` based on `name` attribute contained in them

### `--execute` / `-x`

this flag is used to specify `config.album.commands.sourceTorrent.fetch.<NAME>.package` by single `<NAME>` argument

if flag is omitted -> run `album-fetch-source-default-sourceTorrent` package
