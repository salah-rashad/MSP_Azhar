class Project {
  final int id;
  final String title;
  final String projectLink;
  final String description;
  final String image;
  final List<Staff> staff;
  
  Project(
    {this.id,
      this.title,
      this.projectLink,
      this.description,
      this.image,
      this.staff});
  
  factory Project.fromJson(Map<String, dynamic> json) {
    var list = json['stuff'] as List;
    List<Staff> staffList = list.map((i) => Staff.fromJson(i)).toList();
    
    return Project(
      id: json['id'],
      title: json['title'],
      projectLink: json['projectLink'],
      description: json['description'],
      image: json['imgURL'],
      staff: staffList,
    );
  }
}

class Staff {
  final String name;
  final String img;
  
  Staff({this.name, this.img});
  
  factory Staff.fromJson(Map<String, dynamic> json) {
    return Staff(
      name: json['name'],
      img: json['memberIMG'],
    );
  }
}