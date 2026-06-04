# this file is a documentation of ~/.config/mute/config.nix

{
  # path to custom store
  # it will contain all sources + built albums + entire build system env
  store = "";

  # path to staging directory all `fetch` and first-time `build` will run against
  # it will contain fetched source data in ./{source_type}/{sanitized_source_name}-{nix32_hash} format
  origin = "";

  # tips:
  #   - point both to large storage disk
  #   - backup store periodically; it is the actual source of your entire library
  #   - to garbage collect old albums not in current use run `nix store gc --store ${store}`

  # settings for album media type
  album = {

    # determines existence of additional libraries based on settings
    libraries = {

      # mandatory setting
      main = {

        # main library path containing album.nix files
        # the albums will be built next to album.nix
        root = "path/to/main/library";

        # acts like a flag that determines the encoding of tracks built
        # original -> each track built will have the same extension as in source
        # flac -> encoded in FLAC
        # opus -> encoded in OPUS
        encoding = "";

      };

      # every next libraries.{name} is optional
      # they will be built from folders and symlinks only, fully disposable and 

      # FLAC library
      flac = {

        # path to directory where flac album folders will be created
        # each album folder is populated purely by symlinks to custom store by rust
        root = "";

        encoding = "flac";

        # set of formatting expressions to determine folder tree for each library and file naming
        formatting = {

          # expression that will be used to format each album folder path next to `root`
          folder = "";

          # expression that will be used to format each track path within album `folder`
          tracks = "";

        };

      };

      # OPUS library
      opus = {

        # path to directory where opus album clone folders will be created
        root = "";

        encoding = "opus";

        # etc...

      };
    };
  };

  # commands to run on `fetch` and `build`
  # ${origin.path} resolution happens automatically based on --source specified
  commands = {

    # --source torrent
    torrent = {

      # runs at `mute fetch`
      # reads the torrent file and starts download to origin
      # recommended command:
      # fetch = "transmission-remote -a '${source.torrent.file}' -w '${origin.path}'";
      fetch = "";

      # runs at `mute build`
      # used to verify 100% seedability and pairity to ${source.torrent.file}
      # skipped if auto-resolved ${origin.path} is already in custom store
      # recommended command:
      # verify = "imdl torrent verify '${source.torrent.file}' --content '${origin.path}/${source.torrent.name}'";
      verify = "";

      # runs after successful `mute build`
      # used to ping the torrent daemon with custom-store-bound ${origin.path} to seed from it directly
      seed = "transmission-remote -a '${source.torrent.file}' -w '${origin.path}'";
    };

    # --source torrent
    web = {

      # runs at `mute fetch`
      # recommended command:
      # fetch = "curl -L '${source.web.url}' -o '${origin.path}'";
      fetch = "";
    };
  };
}
