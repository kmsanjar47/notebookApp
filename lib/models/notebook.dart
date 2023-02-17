class Notebook {
  int? id;
  String? title;
  String? description;
  String? timeadded;

  Notebook({this.id, this.title, this.description, this.timeadded});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "timeadded": timeadded,
    };
  }
}
