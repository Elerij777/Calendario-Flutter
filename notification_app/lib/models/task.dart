class Task {
  int? id;
  String? title;
  String? note;
  int? isCompleted;
  String? date;
  String? starTime;
  String? endTime;
  int? color;
  int? reminder;
  String? repeat;
  Task(
      {this.id,
      this.title,
      this.note,
      this.isCompleted,
      this.date,
      this.starTime,
      this.endTime,
      this.color,
      this.reminder,
      this.repeat});
  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    note = json['data'];
    isCompleted = json['isCompleted'];
    date  = json['date'];
    starTime = json['start_time'];
    endTime = json['end_time'];
    color = json['color'];
    reminder = json['reminder'];
    repeat = json['repeat'];
  }

  Map<String, dynamic> toJson(){
    final Map <String,dynamic> data =new Map <String, dynamic>();
    data['id']=this.id;
    data['title']=this.title;
    data['data']=this.note; 
    data['isCompleted']=this.isCompleted;  
    data['date']=this.date;
    data['start_time']=this.starTime;
    data['end_time']=this.endTime;
    data ['color']=this.color;
    data ['reminder']=this.reminder;
    data ['repeat']=this.repeat;

    return data;

  }
}
