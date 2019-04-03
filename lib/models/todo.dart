/// Todo object
class Todo {
  Todo({
    this.id,
    this.title,
    this.desc,
    this.geo,
    this.dueDate,
    this.createdOnDate,
    this.done,
    this.synced,
  });

  int id;
  String title;
  String desc;
  String geo; // TODO: create a geoloaction model
  String dueDate; // TODO: save as DateTime object
  String createdOnDate; // TODO: save as DateTime object
  bool done;
  bool synced;

  factory Todo.fromMap(Map<String, dynamic> json) => Todo(
        id: json["id"],
        title: json["title"],
        desc: json["desc"],
        geo: json["geo"],
        dueDate: json["dueDate"],
        createdOnDate: json["createdOnDate"],
        done: json["done"] == 1,
        synced: json["synced"] == 1,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "desc": desc,
        "geo": geo,
        "dueDate": dueDate,
        "createdOnDate": createdOnDate,
        "done": done,
        "synced": synced,
      };
}
