// ...imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';

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
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 16),
                Center(
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
                              print('Tapped: ${menuOptions[index]}');
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
            Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                icon: Icon(
                  isDarkMode ? Icons.light_mode : Icons.dark_mode,
                  color: textColor,
                ),
                onPressed: () => themeProvider.toggleTheme(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
