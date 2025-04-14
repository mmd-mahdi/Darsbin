import 'dart:convert';

class ClassSchedule {
  final String className;
  final String professorName;
  final String majorName;
  final String university;
  final String location;
  final ClassTime classTime;
  final String classDate;
  final bool isCanceled;
  final String? makeupDate;
  final Midterm midtermExam;
  final Final finalExam;
  final String classCode;
  final String professorCode;

  ClassSchedule({
    required this.className,
    required this.professorName,
    required this.majorName,
    required this.university,
    required this.location,
    required this.classTime,
    required this.classDate,
    required this.isCanceled,
    this.makeupDate,
    required this.midtermExam,
    required this.classCode,
    required this.professorCode,
    required this.finalExam,
  });

  factory ClassSchedule.fromJson(Map<String, dynamic> json) {
    return ClassSchedule(
      className: json['class_name'],
      professorName: json['professor_name'],
      majorName: json['major_name'],
      university: json['university'],
      location: json['location'],
      classTime: ClassTime.fromJson(json['class_time']),
      classDate: json['class_date'],
      isCanceled: json['is_canceled'],
      makeupDate: json['makeup_date'],
      finalExam: Final.fromJson(json['finalExam']),
      midtermExam: Midterm.fromJson(json['midtermExam']),
      classCode: json['class_code'],
      professorCode: json['professor_code'],
    );
  }
}

class ClassTime {
  final String start;
  final String end;

  ClassTime({required this.start, required this.end});

  factory ClassTime.fromJson(Map<String, dynamic> json) {
    return ClassTime(
      start: json['start'],
      end: json['end'],
    );
  }
}
class Final {
  final String date;
  final String time;
  final String location;

  Final({required this.date, required this.time,required this.location});

  factory Final.fromJson(Map<String, dynamic> json) {
    return Final(
      date: json['date'],
      time: json['time'],
      location: json['location'],
    );
  }
}
class Midterm {
  final String date;
  final String time;
  final String location;

  Midterm({required this.date, required this.time,required this.location});

  factory Midterm.fromJson(Map<String, dynamic> json) {
    return Midterm(
      date: json['date'],
      time: json['time'],
      location: json['location'],
    );
  }
}