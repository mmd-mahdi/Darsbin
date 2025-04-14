import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';
import '../theme_toggle_button.dart';
import '../widgets/SearchBarWidget.dart';

class ProfessorClassesScreen extends StatefulWidget {
  final String universityName;
  final String professorName;

  const ProfessorClassesScreen({
    required this.universityName,
    required this.professorName,
  });

  @override
  _ProfessorClassesScreenState createState() => _ProfessorClassesScreenState();
}

class _ProfessorClassesScreenState extends State<ProfessorClassesScreen> {
  String _searchQuery = '';

  // Sample data for professor's classes (List<Map<String, String>> format)
  // We'll use a map to store different schedules for different professors
  final Map<String, List<Map<String, String>>> professorSchedules = {
    'دکتر احمدی': [
      {
        'day': 'شنبه',
        'startTime': '۸:۰۰',
        'endTime': '۹:۳۰',
        'className': 'ریاضی پیشرفته',
        'classCode': 'ش',
      },
      {
        'day': 'دوشنبه',
        'startTime': '۱۰:۰۰',
        'endTime': '۱۱:۳۰',
        'className': 'جبر خطی',
        'classCode': 'ش',
      },
      {
        'day': 'چهارشنبه',
        'startTime': '۱۴:۰۰',
        'endTime': '۱۵:۳۰',
        'className': 'آنالیز عددی',
        'classCode': 'ش',
      },
    ],
    'دکتر رضایی': [
      {
        'day': 'یکشنبه',
        'startTime': '۹:۰۰',
        'endTime': '۱۰:۳۰',
        'className': 'فیزیک کوانتومی',
        'classCode': 'ش',
      },
      {
        'day': 'سه‌شنبه',
        'startTime': '۱۱:۰۰',
        'endTime': '۱۲:۳۰',
        'className': 'مکانیک کلاسیک',
        'classCode': 'ش',
      },
    ],
    'دکتر محمدی': [
      {
        'day': 'شنبه',
        'startTime': '۱۳:۰۰',
        'endTime': '۱۴:۳۰',
        'className': 'برنامه نویسی پیشرفته',
        'classCode': 'ش',
      },
      {
        'day': 'دوشنبه',
        'startTime': '۱۵:۰۰',
        'endTime': '۱۶:۳۰',
        'className': 'هوش مصنوعی',
        'classCode': 'ش',
      },
    ],
    'دکتر حسینی': [
      {
        'day': 'یکشنبه',
        'startTime': '۱۰:۰۰',
        'endTime': '۱۱:۳۰',
        'className': 'شیمی آلی',
        'classCode': 'ش',
      },
      {
        'day': 'سه‌شنبه',
        'startTime': '۱۴:۰۰',
        'endTime': '۱۵:۳۰',
        'className': 'شیمی تجزیه',
        'classCode': 'ش',
      },
    ],
    'دکتر کاظمی': [
      {
        'day': 'دوشنبه',
        'startTime': '۹:۰۰',
        'endTime': '۱۰:۳۰',
        'className': 'مدارهای الکتریکی',
        'classCode': 'ش',
      },
      {
        'day': 'چهارشنبه',
        'startTime': '۱۱:۰۰',
        'endTime': '۱۲:۳۰',
        'className': 'الکترونیک',
        'classCode': 'ش',
      },
    ],
  };

  // Filtered data based on search query
  List<Map<String, String>> get filteredClasses {
    final professorClasses = professorSchedules[widget.professorName] ?? [];
    if (_searchQuery.isEmpty) {
      return professorClasses;
    }
    return professorClasses.where((entry) {
      return entry['className']!.contains(_searchQuery);
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
              // Page title with professor's name
              SizedBox(height: 10),
              Center(
                child: Text(
                  'برنامه ${widget.professorName}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    fontFamily: 'Vazir',
                  ),
                ),
              ),
              // Search bar
              SearchBarWidget(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
              // Table
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columnSpacing: 16,
                      headingRowColor: MaterialStateColor.resolveWith(
                            (states) => Colors.lightBlue,
                      ),
                      dataRowColor: MaterialStateColor.resolveWith(
                            (states) => isDarkMode ? Colors.grey[800]! : Colors.white,
                      ),
                      columns: [
                        DataColumn(
                          label: Text(
                            'روز',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Vazir',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'ساعت شروع',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Vazir',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'ساعت پایان',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Vazir',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'نام درس',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Vazir',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'کد درس',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Vazir',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                      rows: filteredClasses.map((entry) {
                        return DataRow(cells: [
                          DataCell(
                            Text(
                              entry['day']!,
                              style: TextStyle(
                                color: textColor,
                                fontFamily: 'Vazir',
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              entry['startTime']!,
                              style: TextStyle(
                                color: textColor,
                                fontFamily: 'Vazir',
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              entry['endTime']!,
                              style: TextStyle(
                                color: textColor,
                                fontFamily: 'Vazir',
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              entry['className']!,
                              style: TextStyle(
                                color: textColor,
                                fontFamily: 'Vazir',
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              entry['classCode']!,
                              style: TextStyle(
                                color: textColor,
                                fontFamily: 'Vazir',
                              ),
                            ),
                          ),
                        ]);
                      }).toList(),
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