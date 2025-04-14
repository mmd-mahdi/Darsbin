import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';
import '../theme_toggle_button.dart';
import '../widgets/SearchBarWidget.dart';
import 'major_classes_screen.dart'; // Import the major classes screen

class MajorsScheduleScreen extends StatefulWidget {
  final String universityName;

  const MajorsScheduleScreen({required this.universityName});

  @override
  _MajorsScheduleScreenState createState() => _MajorsScheduleScreenState();
}

class _MajorsScheduleScreenState extends State<MajorsScheduleScreen> {
  String _searchQuery = '';

  // Sample list of majors
  final List<String> majorNames = [
    'مهندسی کامپیوتر',
    'مهندسی برق',
    'مهندسی مکانیک',
    'مهندسی شیمی',
    'مهندسی عمران',
    'علوم کامپیوتر',
    'ریاضی کاربردی',
    'فیزیک',
    'شیمی',
    'مدیریت',
    'حسابداری',
    'اقتصاد',
  ];

  // Filtered list of majors based on search query
  List<String> get filteredMajors {
    if (_searchQuery.isEmpty) {
      return majorNames;
    }
    return majorNames.where((major) {
      return major.contains(_searchQuery);
    }).toList();
  }

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
                          'دانشگاه ${widget.universityName}',
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
              SizedBox(height: 10),
              Center(
                child: Text(
                  'برنامه رشته ها',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    fontFamily: 'Vazir',
                  ),
                ),
              ),
              // Search bar for majors
              SearchBarWidget(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
              // List of major buttons
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  itemCount: filteredMajors.length,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Container(
                        width: 170,
                        margin: EdgeInsets.only(bottom: 16),
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigate to MajorClassesScreen with the major's name
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => MajorClassesScreen(
                                  universityName: widget.universityName,
                                  majorName: filteredMajors[index],
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlue,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                            filteredMajors[index],
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