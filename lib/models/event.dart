class Event {
  final String id;
  final String title;
  final String description;
  final String price;
  final String location;
  final String formLink;
  final String date;
  final String time;
  final String img;
  final List<Topic> topics;

  Event({
    this.id,
    this.title,
    this.description,
    this.price,
    this.location,
    this.formLink,
    this.date,
    this.time,
    this.img,
    this.topics,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    var list = json['topics'] as List;
    List<Topic> topicsList = list.map((i) => Topic.fromJson(i)).toList();

    return Event(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      location: json['location'],
      formLink: json['formLink'],
      date: json['date'],
      time: json['time'],
      img: json['imgURL'],
      topics: topicsList,
    );
  }
}

class Topic {
  final String title;
  final String sName;
  final String sJob;

  Topic({this.title, this.sName, this.sJob});

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      title: json['title'],
      sName: json['speakerName'],
      sJob: json['speakerJob'],
    );
  }
}
