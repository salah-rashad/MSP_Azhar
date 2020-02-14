class PlayList {
  List<Video> items;

  PlayList({this.items});

  PlayList.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = new List<Video>();
      json['items'].forEach((v) { items.add(new Video.fromJson(v)); });
    }
  }
}

class Video {
  final String id;
  final String publishedAt;
  final String title;
  final String desc;
  final String imageDefault;
  final String imageMedium;
  final String imageHigh;

  Video({this.id, this.publishedAt, this.title, this.desc, this.imageDefault, this.imageMedium, this.imageHigh});

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json["snippet"]["resourceId"]["videoId"],
      publishedAt: json["snippet"]["publishedAt"],
      title: json["snippet"]["title"],
      desc: json["snippet"]["description"],
      imageDefault: json["snippet"]["thumbnails"]["default"]["url"],
      imageMedium: json["snippet"]["thumbnails"]["medium"]["url"],
      imageHigh: json["snippet"]["thumbnails"]["high"]["url"],
    );
  }
}
