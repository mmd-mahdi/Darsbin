import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';
import '../theme_toggle_button.dart';
import 'daily_schedule_screen.dart';
import 'canceled_classes_screen.dart';
import 'makeup_classes_screen.dart';
import 'exam_schedule_screen.dart';
import 'professors_schedule_screen.dart';
import 'majors_schedule_screen.dart';

class UniversityDashboardScreen extends StatelessWidget {
  final String universityName;

  UniversityDashboardScreen({required this.universityName});

  final List<String> menuOptions = [
    'برنامه روزانه',
    'کلاس های لغو شده',
    'کلاس های جبرانی',
    'برنامه رشته ها',
    'برنامه امتحانی',
    'برنامه اساتید',
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final backgroundColor = isDarkMode ? const Color(0xFF383C4A) : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header with University Name and ThemeToggleButton
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 48), // Placeholder to balance the row on the left
                  Expanded(
                    child: Center(
                      child: Text(
                        'دانشگاه $universityName',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                          fontFamily: 'Vazir',
                        ),
                      ),
                    ),
                  ),
                  ThemeToggleButton(), // Moved to the right side
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 8),
                itemCount: menuOptions.length,
                itemBuilder: (context, index) {
                  return Center(
                    child: Container(
                      width: 170,
                      margin: EdgeInsets.only(bottom: 16),
                      child: ElevatedButton(
                        onPressed: () {
                          if (menuOptions[index] == 'برنامه روزانه') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DailyScheduleScreen(universityName: universityName),
                              ),
                            );
                          } else if (menuOptions[index] == 'کلاس های لغو شده') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CanceledClassesScreen(universityName: universityName),
                              ),
                            );
                          } else if (menuOptions[index] == 'کلاس های جبرانی') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => MakeupClassesScreen(universityName: universityName),
                              ),
                            );
                          } else if (menuOptions[index] == 'برنامه رشته ها') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => MajorsScheduleScreen(universityName: universityName),
                              ),
                            );
                          } else if (menuOptions[index] == 'برنامه امتحانی') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ExamScheduleScreen(universityName: universityName),
                              ),
                            );
                          } else if (menuOptions[index] == 'برنامه اساتید') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ProfessorsScheduleScreen(universityName: universityName),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlue,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          menuOptions[index],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Vazir',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}