import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';
import '../screens/university_selection_screen.dart';

class CustomNavBar extends StatelessWidget {
  final String universityName;

  const CustomNavBar({required this.universityName});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: isDark ? Colors.white10.withOpacity(0.25) : Colors.black12.withOpacity(0.15),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              color: isDark ? Colors.white : Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(width: 16),
            IconButton(
              icon: Icon(Icons.home),
              color: isDark ? Colors.white : Colors.black,
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => UniversitySelectionScreen()),
                      (route) => false,
                );
              },
            ),
            SizedBox(width: 16),
            IconButton(
              icon: Icon(Icons.dashboard),
              color: isDark ? Colors.white : Colors.black,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('شما در صفحه داشبورد هستید')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
