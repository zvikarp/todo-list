import 'dart:convert';

/// Todo object
class Todo {
  Todo({
    this.id,
    this.title,
    this.desc,
    this.geo,
    this.todoByDate,
    this.createdOnDate,
    this.done,
    this.synced,
  });

  int id;
  String title;
  String desc;
  String geo; // TODO: create a geoloaction model
  String todoByDate; // TODO: save as DateTime object
  String createdOnDate; // TODO: save as DateTime object
  bool done;
  bool synced;

  factory Todo.fromMap(Map<String, dynamic> json) => Todo(
        id: json["id"],
        title: json["title"],
        desc: json["desc"],
        geo: json["geo"],
        todoByDate: json["todoByDate"],
        createdOnDate: json["createdOnDate"],
        done: json["done"] == 1,
        synced: json["synced"] == 1,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "desc": desc,
        "geo": geo,
        "todoByDate": todoByDate,
        "createdOnDate": createdOnDate,
        "done": done,
        "synced": synced,
      };
}
