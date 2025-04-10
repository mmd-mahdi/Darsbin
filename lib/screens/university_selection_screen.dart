import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';
import 'university_dashboard_screen.dart';

class UniversitySelectionScreen extends StatelessWidget {
  final List<String> universities = [
    'خلیج فارس',
    'شیراز',
    'تهران',
    'صنعتی شریف',
    'اصفهان',
    'تبریز',
    'علامه طباطبایی',
    'خواجه نصیر',
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: themeProvider.isDarkMode ? Color(0xFF383C4A) : Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(
                    themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                    color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                  ),
                  onPressed: () {
                    themeProvider.toggleTheme();
                  },
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Image.asset(
                          'assets/images/logo.png',
                          width: 150,
                          height: 150,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'سامانه درس بین',
                          style: TextStyle(
                            color: Colors.lightBlue,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Vazir',
                          ),
                        ),
                        SizedBox(height: 30),
                        Text(
                          'انتخاب دانشگاه:',
                          style: TextStyle(
                            color: themeProvider.isDarkMode ? Colors.white : Color(0xff4a4a4a),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Vazir',
                          ),
                        ),
                        SizedBox(height: 20),
                        ...universities.map(
                              (name) => UniversityButton(
                            universityName: name,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => UniversityDashboardScreen(universityName: name),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UniversityButton extends StatelessWidget {
  final String universityName;
  final VoidCallback onTap;

  const UniversityButton({
    required this.universityName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      margin: EdgeInsets.only(bottom: 20),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.lightBlue,
          padding: EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          universityName,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontFamily: 'Vazir',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
