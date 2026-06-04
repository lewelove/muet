# mute album manifest

## FLAGS

### -m / --metadata

this flag handles sources for intermediary json generation and can be repeated any number of times

-m flag has two arguments

example: `mute album manifest -m <NAME> <PATH>`

all <NAME> providers must have dedicated <PATH> to json/toml file, resolved either by cli argument or automatic fallback based on <NAME>

when .toml file is specified in path rust automatically converts it to json

examples:
    `mute album manifest -m musicbrainz ./mb.json -m discogs ./discogs.json`
    `mute album manifest -m musicbrainz -m discogs` (config paths required)

### -M

-M can be used to specify providers by name separated by space, relying entirely on config defined paths

examples:
    `mute album manifest -M musicbrainz discogs` (config paths required)

### -s

this flag is used to specify source

