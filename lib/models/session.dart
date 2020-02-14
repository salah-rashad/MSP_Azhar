class Session {
  final String id;
  final String name;
  final String courseLink;

  Session({
    this.id,
    this.name,
    this.courseLink,
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      id: json['id'],
      name: json['name'],
      courseLink: json['courseLink'],
    );
  }
}
