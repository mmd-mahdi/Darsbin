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
  final String finalExamDate;
  final String midtermExamDate;
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
    required this.finalExamDate,
    required this.midtermExamDate,
    required this.classCode,
    required this.professorCode,
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
      finalExamDate: json['final_exam_date'],
      midtermExamDate: json['midterm_exam_date'],
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