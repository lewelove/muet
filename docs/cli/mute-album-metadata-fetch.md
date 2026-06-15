# `mute album metadata fetch`

`mute album metadata fetch` is a command that is used to fetch album data from external providers and save it within album folder for further consumption by `mute album manifest`

## METADATA PROVIDERS FLAGS

### `-p` / `--provider`

this flag handles specification of external metadata providers to fetch the `.json` file

it has 2 arguments:
- `mute album metadata fetch -p <NAME> <VALUE>`

`<NAME>`
- script name

`<VALUE>`
- string value to pass to script
- if system path to a file -> canonicalize and pass the path string to script

each `<NAME>` must be directly associated with specific script set in config that will execute with `<VALUE>` as single input argument

example:
- `mute album metadata fetch -p musicbrainz https://...`

### `-P` & `-a`

these two can be used to call scripts by name and provide single argument for each of them. useful if one argument can lead to different providers

- `mute album metadata fetch -P <NAME> <NAME> -a <VALUE>`

`<NAME>`
- script name

`<VALUE>`
- string value to pass to ALL scripts in `-P`
- if system path to a file -> canonicalize and pass the path string to all scripts

if `-P` is used `-a` must exist as well

example:
- `mute album metadata fetch -P musicbrainz discogs -a https://...`

## BUILTIN SCRIPTS

### `musicbrainz`

this script ingests url string to either album `release` or `release-group`

`https://musicbrainz.org/release/...`
- fetches musicbrainz release json
- resolves `musicbrainz.org/release-group/...` url
- fetches musicbrainz release-group json
- generates `musicbrainz.json` containing both `"release": {}` and `"release-group": {}`

`https://musicbrainz.org/release-group/...`
- resolves release-group and fetches its json too
- generates json containing `"release-group": {}` only

### `discogs`

this script can ingest both musicbrainz `release` and `release-group` urls or discogs `release` and `master`

`https://musicbrainz.org/release/...`
- resolves `discogs.com/release/...` url
- resolves discogs master url
- fetches both discogs release & master json
- generates `discogs.json` containing both `"release": {}` and `"master": {}`

`https://musicbrainz.org/release-group/...`
- resolves `discogs.com/master/...` url
- fetches discogs master json
- generates `discogs.json` containing `"master": {}` only

`https://www.discogs.com/release/...`
- resolves `discogs.com/master/...` url
- fetches both discogs release & master jsons
- generates `discogs.json` containing both `"release": {}` and `"master": {}`

`https://www.discogs.com/master/...`
- fetches discogs master json
- generates `discogs.json` containing `"master": {}` only
