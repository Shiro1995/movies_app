class VideoTrailers {
  int? id;
  List<VideoTrailer> results = [];
  VideoTrailers();

  VideoTrailers.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    List<VideoTrailer> temp = [];
    for (int i = 0; i < parsedJson['results'].length; i++) {
      VideoTrailer videotrailers = VideoTrailer(parsedJson['results'][i]);
      temp.add(videotrailers);
    }

    results = temp;
  }
}

class VideoTrailer {
  String? id;
  String? iso_639_1;
  String? iso_3166_1;
  String? key;
  String? name;
  String? site;
  int? size;
  String? type;

  VideoTrailer(videotrailer) {
    id = videotrailer['id'];
    iso_639_1 = videotrailer['iso_639_1'];
    iso_3166_1 = videotrailer['iso_3166_1'];
    key = videotrailer['key'];
    name = videotrailer['name'];
    site = videotrailer['site'];
    size = videotrailer['size'];
    type = videotrailer['type'];
  }
}
