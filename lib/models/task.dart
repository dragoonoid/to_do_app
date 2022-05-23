class Task {
  int? id;
  String? title, note;
  String? date;
  String? startTime, endTime;
  int? color;
  int? remind;
  String? repeat;
  int? isCompleted;

  Task(
      {this.id,
      this.title,
      this.note,
      this.date,
      this.startTime,
      this.endTime,
      this.remind,
      this.repeat,
      this.color,
      this.isCompleted});

  Task.mapToList(Map<String, dynamic> mp) {
    id = mp['id'];
    title = mp['title'];
    note = mp['note'];
    date = mp['date'];
    startTime = mp['startTime'];
    endTime = mp['endTime'];
    color = mp['color'];
    remind = mp['remind'];
    repeat = mp['repeat'];
    isCompleted = mp['isCompleted'];
  }

  Map<String, dynamic> listToMap() {
    Map<String, dynamic> mp = <String, dynamic>{};
    mp['id'] = id;
    mp['title'] = title;
    mp['note'] = note;
    mp['date'] = date;
    mp['startTime'] = startTime;
    mp['endTime'] = endTime;
    mp['color'] = color;
    mp['remind'] = remind;
    mp['repeat'] = repeat;
    mp['isCompleted'] = isCompleted;
    return mp;
  }
}
