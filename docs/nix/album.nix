# this file is the documentation of album.nix attributes

{ mute }:

let

  main = mute.sourceTorrent {

    # name used to specify source in staging directory
    # absolutely required
    name = "name-of-the-source";

    # path to .torrent file
    file = ./Info/source.torrent;

    # file hash of fetch.torrent.file
    hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";

    # origin is required to separate the imperative fetch
    # from actual local hash pinned data the album is built from
    origin = {
      # auto resolved by rust within staging directory based on selected source or lack there of
      path = "";
      # NAR hash of origin.path
      hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
    };
  };

  cover = mute.sourceDisk {
    name = "";
    origin = {
      path = "";
      hash = "";
    };
  };

in

{

mute.mkAlbum {

  # album name in "{albumartist}-{album} -> lowercase -> sanitize with `-`" format
  name = "";

  cover = "${cover}/cover.png";

  album = {
    # metadata keys for all tracks following Vorbis standard
    metadata = {
    };
    # list of musicbrainz ids for all tracks 
    mbid = {
      musicbrainz_albumid = "";
      musicbrainz_albumartistid = "";
      musicbrainz_releasegroupid = "";
    };
  };

  tracks = [
    {
      # path to track file relative to origin.path directory
      file = "${main}/track01.flac";
      # metadata keys for specific track following Vorbis standard
      metadata = {
      };
      # list of musicbrainz ids for specific track
      mbid = {
        musicbrainz_trackid = "";
        musicbrainz_releasetrackid = "";
        musicbrainz_artistid = "";
      };
    }
    # {
    #   etc...
    # }
  ];
};

}
