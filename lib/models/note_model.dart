class NoteModel {
  int? id;
  String? description;
  String? title;
  String? dateTimeEdited;
  String? dateTimeCreated;

  NoteModel({
    this.id,
    this.description,
    this.title,
    this.dateTimeEdited,
    this.dateTimeCreated,
  });

  NoteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    title = json['title'];
    dateTimeCreated = json["dateTimeCreated"];
    dateTimeEdited = json["dateTimeEdited"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['title'] = this.title;
    data["dateTimeEdited"] = this.dateTimeEdited;
    data["dateTimeCreated"] = this.dateTimeCreated;
    return data;
  }
}
