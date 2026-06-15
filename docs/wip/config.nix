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

  album = {
  # determines existence of additional libraries based on extention
    libraries = {

      main = {};

      # FLAC library
      # album counts towards one if all input tracks have .flac extension
      flac = {

        # will flac albums be built at all
        enable = true;

        # path to directory where flac album folders will be created
        # naming pattern "AlbumArtist - Album" is used
        # each album folder is populated purely by symlinks to custom store by rust
        root = "";

        # will flac album contents be linked by rust to folder containing album.nix
        link_to_album_root = true;

        # will flac album contents be linked by rust to folder in library.flac.root
        link_to_library_root = true;
      };

      # OPUS library
      opus = {

        # will albums be built to have .opus clones
        enable = true;

        # used as argument for conversion
        # optional: defaults to 128 if missing
        kbps = 128;

        # path to directory where opus album clone folders will be created
        root = "";

        # will opus album contents be linked by rust to folder containing album.nix
        link_to_album_root = false;

        # will opus album contents be linked by rust to folder in library.opus.root
        link_to_library_root = true;
      };
    };

    # specifies default arguments for all `mute album <subcommand>` calls
    arguments = {

      # mute album fetch metadata
      fetch.metadata = {
        providers = {

          # the <name>
          musicbrainz = {

            # relative paths where `album metadata fetch -p <provider> <value>` will be saved to
            path = "Info/musicbrainz.json";

            # way to specify the fetcher binary that will be ran from `outputs.packages.${system}`
            package = "album-metadata-fetch-musicbrainz"
          };

          discogs = {
            path = "Info/discogs.json";
            package = "album-metadata-fetch-discogs"
          };
        };
      };

      # mute album manifest
      manifest = {

        # -M / -m / --metadata
        metadata = {
          musicbrainz.path = ./Info/musicbrainz.json;
          discogs.path = ./Info/discogs.json;
        };

        # --st / --source-torrent
        sourceTorrent = {
          main = {
            path = "./source.torrent";
            filter = "**/*";
          };
        };

        # --sd / --source-disk
        sourceDisk = {
          cover = {
            path = "./cover.png";
            filter = "**/*";
          };
        };

        # sets packages to execute against produces intermediary
        execute = {

          # way to specify the manifest binary that will be ran from `outputs.packages.${system}`
          default.package = "album-manifest-default";

          name.package = "album-manifest-name";
        };
      };
    };
  };

  # commands to run on `fetch` and `build`
  # ${origin.path} resolution happens automatically based on --source specified
  commands = {

    sourceTorrent = {

      # runs at `mute album fetch source --st`
      # reads the package and executes it
      fetch.default.package = "album-fetch-source-default-sourceTorrent";

      # runs at `mute album build`
      # used to verify 100% seedability and pairity to ${source.torrent.file}
      verify.default.package = "album-build-verify-default-sourceTorrent";

      # runs after successful `mute build`
      # used to ping the torrent daemon with custom-store-bound ${origin.path} to seed from it directly
      seed.default.package = "album-build-seed-default-sourceTorrent";
    };
  };
}
