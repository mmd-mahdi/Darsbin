import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';
import '../theme_toggle_button.dart';
import '../widgets/SearchBarWidget.dart';

class MajorClassesScreen extends StatefulWidget {
  final String universityName;
  final String majorName;

  const MajorClassesScreen({
    required this.universityName,
    required this.majorName,
  });

  @override
  _MajorClassesScreenState createState() => _MajorClassesScreenState();
}

class _MajorClassesScreenState extends State<MajorClassesScreen> {
  String _searchQuery = '';

  // Sample data for major's classes (List<Map<String, String>> format)
  // We'll use a map to store different schedules for different majors
  final Map<String, List<Map<String, String>>> majorSchedules = {
    'مهندسی کامپیوتر': [
      {
        'day': 'شنبه',
        'startTime': '۸:۰۰',
        'endTime': '۹:۳۰',
        'className': 'الگوریتم',
        'classCode': 'ش',
      },
      {
        'day': 'دوشنبه',
        'startTime': '۱۰:۰۰',
        'endTime': '۱۱:۳۰',
        'className': 'سیستم عامل',
        'classCode': 'ش',
      },
      {
        'day': 'چهارشنبه',
        'startTime': '۱۴:۰۰',
        'endTime': '۱۵:۳۰',
        'className': 'پایگاه داده',
        'classCode': 'ش',
      },
    ],
    'مهندسی برق': [
      {
        'day': 'یکشنبه',
        'startTime': '۹:۰۰',
        'endTime': '۱۰:۳۰',
        'className': 'مدارهای الکتریکی',
        'classCode': 'ش',
      },
      {
        'day': 'سه‌شنبه',
        'startTime': '۱۱:۰۰',
        'endTime': '۱۲:۳۰',
        'className': 'الکترونیک',
        'classCode': 'ش',
      },
    ],
    'مهندسی مکانیک': [
      {
        'day': 'شنبه',
        'startTime': '۱۳:۰۰',
        'endTime': '۱۴:۳۰',
        'className': 'ترمودینامیک',
        'classCode': 'ش',
      },
      {
        'day': 'دوشنبه',
        'startTime': '۱۵:۰۰',
        'endTime': '۱۶:۳۰',
        'className': 'مکانیک سیالات',
        'classCode': 'ش',
      },
    ],
    'مهندسی شیمی': [
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
        'className': 'انتقال جرم',
        'classCode': 'ش',
      },
    ],
    'مهندسی عمران': [
      {
        'day': 'دوشنبه',
        'startTime': '۹:۰۰',
        'endTime': '۱۰:۳۰',
        'className': 'مقاومت مصالح',
        'classCode': 'ش',
      },
      {
        'day': 'چهارشنبه',
        'startTime': '۱۱:۰۰',
        'endTime': '۱۲:۳۰',
        'className': 'طراحی سازه',
        'classCode': 'ش',
      },
    ],
    'علوم کامپیوتر': [
      {
        'day': 'شنبه',
        'startTime': '۸:۰۰',
        'endTime': '۹:۳۰',
        'className': 'هوش مصنوعی',
        'classCode': 'ش',
      },
      {
        'day': 'دوشنبه',
        'startTime': '۱۰:۰۰',
        'endTime': '۱۱:۳۰',
        'className': 'شبکه‌های کامپیوتری',
        'classCode': 'ش',
      },
    ],
    'ریاضی کاربردی': [
      {
        'day': 'یکشنبه',
        'startTime': '۹:۰۰',
        'endTime': '۱۰:۳۰',
        'className': 'آنالیز عددی',
        'classCode': 'ش',
      },
      {
        'day': 'سه‌شنبه',
        'startTime': '۱۱:۰۰',
        'endTime': '۱۲:۳۰',
        'className': 'جبر خطی',
        'classCode': 'ش',
      },
    ],
    'فیزیک': [
      {
        'day': 'دوشنبه',
        'startTime': '۱۳:۰۰',
        'endTime': '۱۴:۳۰',
        'className': 'فیزیک کوانتومی',
        'classCode': 'ش',
      },
      {
        'day': 'چهارشنبه',
        'startTime': '۱۵:۰۰',
        'endTime': '۱۶:۳۰',
        'className': 'مکانیک کلاسیک',
        'classCode': 'ش',
      },
    ],
    'شیمی': [
      {
        'day': 'یکشنبه',
        'startTime': '۱۰:۰۰',
        'endTime': '۱۱:۳۰',
        'className': 'شیمی تجزیه',
        'classCode': 'ش',
      },
      {
        'day': 'سه‌شنبه',
        'startTime': '۱۴:۰۰',
        'endTime': '۱۵:۳۰',
        'className': 'شیمی معدنی',
        'classCode': 'ش',
      },
    ],
    'مدیریت': [
      {
        'day': 'دوشنبه',
        'startTime': '۹:۰۰',
        'endTime': '۱۰:۳۰',
        'className': 'مدیریت منابع انسانی',
        'classCode': 'ش',
      },
      {
        'day': 'چهارشنبه',
        'startTime': '۱۱:۰۰',
        'endTime': '۱۲:۳۰',
        'className': 'مدیریت استراتژیک',
        'classCode': 'ش',
      },
    ],
    'حسابداری': [
      {
        'day': 'شنبه',
        'startTime': '۸:۰۰',
        'endTime': '۹:۳۰',
        'className': 'حسابداری مالی',
        'classCode': 'ش',
      },
      {
        'day': 'دوشنبه',
        'startTime': '۱۰:۰۰',
        'endTime': '۱۱:۳۰',
        'className': 'حسابداری مدیریت',
        'classCode': 'ش',
      },
    ],
    'اقتصاد': [
      {
        'day': 'یکشنبه',
        'startTime': '۹:۰۰',
        'endTime': '۱۰:۳۰',
        'className': 'اقتصاد خرد',
        'classCode': 'ش',
      },
      {
        'day': 'سه‌شنبه',
        'startTime': '۱۱:۰۰',
        'endTime': '۱۲:۳۰',
        'className': 'اقتصاد کلان',
        'classCode': 'ش',
      },
    ],
  };

  // Filtered data based on search query
  List<Map<String, String>> get filteredClasses {
    final majorClasses = majorSchedules[widget.majorName] ?? [];
    if (_searchQuery.isEmpty) {
      return majorClasses;
    }
    return majorClasses.where((entry) {
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
              // Page title with major's name
              SizedBox(height: 10),
              Center(
                child: Text(
                  'برنامه ${widget.majorName}',
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