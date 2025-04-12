import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamsi_date/shamsi_date.dart';
import '../theme_provider.dart';
import '../theme_toggle_button.dart';

class DailyScheduleScreen extends StatefulWidget {
  final String universityName;

  const DailyScheduleScreen({required this.universityName});

  @override
  _DailyScheduleScreenState createState() => _DailyScheduleScreenState();
}

class _DailyScheduleScreenState extends State<DailyScheduleScreen> {
  late Jalali _selectedDate;

  @override
  void initState() {
    super.initState();
    // Initialize with today's date in Jalali calendar
    _selectedDate = Jalali.now();
  }

  // Sample data (List<Map<String, String>> format)
  final List<Map<String, String>> scheduleData = [
    // Saturday
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
      'day': 'شنبه',
      'startTime': '۱۳:۳۰',
      'endTime': '۱۵:۰۰',
      'className': 'زبان تخصصی',
      'classCode': 'ش',
    },
    {
      'day': 'شنبه',
      'startTime': '۱۵:۰۰',
      'endTime': '۱۶:۳۰',
      'className': 'شبکه',
      'classCode': 'ش',
    },
    // Sunday
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
      'day': 'یکشنبه',
      'startTime': '۱۱:۰۰',
      'endTime': '۱۲:۳۰',
      'className': 'پایگاه داده',
      'classCode': 'ش',
    },
    {
      'day': 'یکشنبه',
      'startTime': '۱۳:۳۰',
      'endTime': '۱۵:۰۰',
      'className': 'زبان تخصصی',
      'classCode': 'ش',
    },
    {
      'day': 'یکشنبه',
      'startTime': '۱۵:۰۰',
      'endTime': '۱۶:۳۰',
      'className': 'شبکه',
      'classCode': 'ش',
    },
    // Monday
    {
      'day': 'دوشنبه',
      'startTime': '۸:۰۰',
      'endTime': '۹:۳۰',
      'className': 'الگوریتم',
      'classCode': 'ش',
    },
    {
      'day': 'دوشنبه',
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
      'day': 'دوشنبه',
      'startTime': '۱۳:۳۰',
      'endTime': '۱۵:۰۰',
      'className': 'زبان تخصصی',
      'classCode': 'ش',
    },
    {
      'day': 'دوشنبه',
      'startTime': '۱۵:۰۰',
      'endTime': '۱۶:۳۰',
      'className': 'شبکه',
      'classCode': 'ش',
    },
    // Tuesday
    {
      'day': 'سه‌شنبه',
      'startTime': '۸:۰۰',
      'endTime': '۹:۳۰',
      'className': 'الگوریتم',
      'classCode': 'ش',
    },
    {
      'day': 'سه‌شنبه',
      'startTime': '۹:۳۰',
      'endTime': '۱۱:۰۰',
      'className': 'سیستم عامل',
      'classCode': 'ش',
    },
    {
      'day': 'سه‌شنبه',
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
      'day': 'سه‌شنبه',
      'startTime': '۱۵:۰۰',
      'endTime': '۱۶:۳۰',
      'className': 'شبکه',
      'classCode': 'ش',
    },
    // Wednesday
    {
      'day': 'چهارشنبه',
      'startTime': '۸:۰۰',
      'endTime': '۹:۳۰',
      'className': 'الگوریتم',
      'classCode': 'ش',
    },
    {
      'day': 'چهارشنبه',
      'startTime': '۹:۳۰',
      'endTime': '۱۱:۰۰',
      'className': 'سیستم عامل',
      'classCode': 'ش',
    },
    {
      'day': 'چهارشنبه',
      'startTime': '۱۱:۰۰',
      'endTime': '۱۲:۳۰',
      'className': 'پایگاه داده',
      'classCode': 'ش',
    },
    {
      'day': 'چهارشنبه',
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

  // Increment date by one day
  void _incrementDate() {
    setState(() {
      _selectedDate = _selectedDate.addDays(1);
    });
  }

  // Decrement date by one day
  void _decrementDate() {
    setState(() {
      _selectedDate = _selectedDate.addDays(-1);
    });
  }

  // Show Jalali date picker
  Future<void> _selectDate(BuildContext context) async {
    // Convert Jalali to DateTime for the date picker
    final DateTime initialDate = _selectedDate.toDateTime();
    final DateTime firstDate = Jalali(1300, 1, 1).toDateTime();
    final DateTime lastDate = Jalali(1500, 12, 29).toDateTime();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.lightBlue,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.lightBlue,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      // Convert selected DateTime back to Jalali
      final Jalali selectedJalali = Jalali.fromDateTime(picked);
      setState(() {
        _selectedDate = selectedJalali;
      });
    }
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
              // University name (same position as dashboard)
              SizedBox(height: 16),
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
                  'برنامه روزانه',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    fontFamily: 'Vazir',
                  ),
                ),
              ),
              // Date selector with arrows
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_right, color: textColor),
                      onPressed: _incrementDate,
                    ),
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${_selectedDate.year}/${_selectedDate.month}/${_selectedDate.day}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Vazir',
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_left, color: textColor),
                      onPressed: _decrementDate,
                    ),
                  ],
                ),
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
                      rows: scheduleData.map((entry) {
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