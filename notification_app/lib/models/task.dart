class Task {
  int? id;
  String? title;
  String? note;
  String? tipo;
  int? isCompleted;
  String date; // Cambiado a String no nulo
  String starTime; // Cambiado a String no nulo
  String endTime; // Cambiado a String no nulo
  int? color;
  int? reminder;
  String? repeat;

  Task({
    this.id,
    this.title,
    this.note,
    this.tipo,
    this.isCompleted,
    required this.date,
    required this.starTime,
    required this.endTime,
    this.color,
    this.reminder,
    this.repeat,
  });

  Task.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        note = json['note'],
        tipo = json['tipo'],
        isCompleted = json['isCompleted'],
        date = json['date'] ?? "", // Manejar el caso en que date sea nulo
        starTime = json['startTime'] ??
            "", // Manejar el caso en que startTime sea nulo
        endTime =
            json['endTime'] ?? "", // Manejar el caso en que endTime sea nulo
        color = json['color'],
        reminder = json['remind'],
        repeat = json['repeat'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['note'] = this.note;
    data['tipo'] = this.tipo;
    data['isCompleted'] = this.isCompleted;
    data['date'] = this.date;
    data['startTime'] = this.starTime;
    data['endTime'] = this.endTime;
    data['color'] = this.color;
    data['remind'] = this.reminder;
    data['repeat'] = this.repeat;

    return data;
  }
}
