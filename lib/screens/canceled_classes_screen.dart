import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';
import '../theme_toggle_button.dart';
import '../widgets/SearchBarWidget.dart';

class CanceledClassesScreen extends StatefulWidget {
  final String universityName;

  const CanceledClassesScreen({required this.universityName});

  @override
  _CanceledClassesScreenState createState() => _CanceledClassesScreenState();
}

class _CanceledClassesScreenState extends State<CanceledClassesScreen> {
  String _searchQuery = '';

  // Sample data for canceled classes (List<Map<String, String>> format)
  final List<Map<String, String>> canceledClassesData = [
    {
      'day': 'شنبه',
      'startTime': '۸:۰۰',
      'endTime': '۹:۳۰',
      'className': 'الگوریتم',
      'classCode': 'ش',
    },
    {
      'day': 'شنبه',
      'startTime': '۹:۳۰',
      'endTime': '۱۱:۰۰',
      'className': 'سیستم عامل',
      'classCode': 'ش',
    },
    {
      'day': 'شنبه',
      'startTime': '۱۱:۰۰',
      'endTime': '۱۲:۳۰',
      'className': 'پایگاه داده',
      'classCode': 'ش',
    },
    {
      'day': 'یکشنبه',
      'startTime': '۸:۰۰',
      'endTime': '۹:۳۰',
      'className': 'الگوریتم',
      'classCode': 'ش',
    },
    {
      'day': 'یکشنبه',
      'startTime': '۹:۳۰',
      'endTime': '۱۱:۰۰',
      'className': 'سیستم عامل',
      'classCode': 'ش',
    },
    {
      'day': 'دوشنبه',
      'startTime': '۱۱:۰۰',
      'endTime': '۱۲:۳۰',
      'className': 'پایگاه داده',
      'classCode': 'ش',
    },
    {
      'day': 'سه‌شنبه',
      'startTime': '۱۳:۳۰',
      'endTime': '۱۵:۰۰',
      'className': 'زبان تخصصی',
      'classCode': 'ش',
    },
    {
      'day': 'چهارشنبه',
      'startTime': '۱۵:۰۰',
      'endTime': '۱۶:۳۰',
      'className': 'شبکه',
      'classCode': 'ش',
    },
  ];

  // Filtered data based on search query
  List<Map<String, String>> get filteredClasses {
    if (_searchQuery.isEmpty) {
      return canceledClassesData;
    }
    return canceledClassesData.where((entry) {
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
              // Theme toggle button
              ThemeToggleButton(),
              SizedBox(height: 8), // Reduced from 16 to 8
              Center(
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
              // Page title
              SizedBox(height: 10),
              Center(
                child: Text(
                  'کلاس های لغو شده',
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