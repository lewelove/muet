# mute album manifest

`mute album manifest` is a command used to generate intermediary json, containing all information from external metadata providers and local sources, that then passed to album.nix templating function to consume it and provide `album.nix` in stdout.

## METADATA FLAGS

### `--metadata` / `-m`

this flag handles filesystem metadata sources for intermediary json generation and can be repeated any number of times

has 2 arguments:
- `mute album manifest -m <NAME> <PATH>`

all `<NAME>` providers must have dedicated `<PATH>` to json/toml file, resolved either by cli argument or automatic fallback based on `<NAME>`

when .toml file is specified in path rust automatically converts it to json

examples:
- `mute album manifest -m musicbrainz ./mb.json -m discogs ./discogs.json`
- `mute album manifest -m musicbrainz -m discogs` (config paths required)

### `-M`

`-M` can be used to specify providers by name separated by space, relying entirely on config defined paths

examples:
- `mute album manifest -M musicbrainz discogs` (config paths required)

## SOURCE FLAGS

these flags handle the specification of `sourceTorrent` / `sourceDisk` name, path and filter expression

### `--source-torrent` / `--st`

`--source-torrent` is used to provide source based on .torrent file for `mute` to read and generate appropriate intermediary json attribute

can have either 3 or 1 arguments:
- `mute album manifest --st <NAME>`
- `mute album manifest --st <NAME> <PATH> <FILTER_EXPRESSION>`

if 3 arguments:

`<NAME>`
- used to provide a key for source attribute in intermediary.

`<PATH>`
- must always be a valid `.torrent` file.

`<FILTER_EXPRESSION>`
- additional argument used to filter files registered in `<PATH>`. if all files must be included use `**/*`

examples:
- `mute album manifest --st main album.torrent '**/*.flac'` -> provides all `.flac` files registered in `album.torrent` at any depth
- `mute album manifest --st main discography.torrent '**/*Album Name*/*.flac'` -> provides `.flac` files registered in `discography.torrent` for folder that contains `Album Name`
- `mute album manifest --st covers album_covers.torrent '**/*'` -> provides all files from `album_covers.torrent`

if 1 argument:

`<NAME>`
- used to provide a key for source attribute in intermediary.
- other arguments are read from config by `<NAME>`.

example:
- `mute album manifest --st main` -> `main`'s `<PATH>` and `<FILTER_EXPRESSION>` are read from config

### `--source-disk` / `--sd`

## SCRIPT EXECUTION FLAG

### `--execute` / `-x`

`--execute` is used to specify script that will consume intermediary json and provide stdout by name

if `--execute` is omitted -> the package falls back to `album-manifest-default`

has 1 argument:
- `mute album manifest --execute <NAME>`

`<NAME>`
- targets the `config.album.arguments.manifest.execute.<NAME>.package` to execute

example:
- `mute album manifest -M musicbrainz --st main --execute main_script`

