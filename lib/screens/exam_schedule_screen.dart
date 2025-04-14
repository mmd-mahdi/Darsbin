import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';
import '../theme_toggle_button.dart';
import 'midterm_exams_screen.dart'; // Import the midterm exams screen
import 'final_exams_screen.dart'; // Import the final exams screen

class ExamScheduleScreen extends StatelessWidget {
  final String universityName;

   ExamScheduleScreen({required this.universityName});

  final List<String> examOptions = [
    'میانترم',
    'پایانترم',
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final backgroundColor = isDarkMode ? const Color(0xFF383C4A) : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              // Header with ThemeToggleButton and University Name
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ThemeToggleButton(),
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
                    SizedBox(width: 48), // Placeholder to balance the row
                  ],
                ),
              ),
              // Page title
              SizedBox(height: 20),
              Center(
                child: Text(
                  'برنامه امتحانی',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    fontFamily: 'Vazir',
                  ),
                ),
              ),
              // List of buttons
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  itemCount: examOptions.length,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Container(
                        width: 170,
                        margin: EdgeInsets.only(bottom: 16),
                        child: ElevatedButton(
                          onPressed: () {
                            if (examOptions[index] == 'میانترم') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => MidtermExamsScreen(universityName: universityName),
                                ),
                              );
                            } else if (examOptions[index] == 'پایانترم') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => FinalExamsScreen(universityName: universityName),
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
                            examOptions[index],
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
      ),
    );
  }
}