import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'class_schedule.dart';

class ScheduleService {
  Future<List<ClassSchedule>> loadScheduleData() async {
    try {
      final String response = await rootBundle.loadString('assets/university_schedule_data.json');
      final List<dynamic> data = jsonDecode(response);
      return data.map((json) => ClassSchedule.fromJson(json)).toList();
    } catch (e) {
      print('Error loading schedule data: $e');
      return [];
    }
  }
}