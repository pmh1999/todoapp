
class Todo {
  String? id;
  String? title;
  String? task;
  bool? done;

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      "title": title,
      "task": task,
      "completed": done == true ? 1 : 0
    };
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

  Todo(this.id, this.title, this.task, this.done);

  Todo.fromMap(Map<String, Object?> map) {
    id = map["id"] as String?;
    title = map["title"] as String?;
    task = map["task"] as String?;
    done = map["completed"] == 1;
  }
}
