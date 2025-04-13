import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamsi_date/shamsi_date.dart' as shamsi;
import '../theme_provider.dart';
import '../theme_toggle_button.dart';

class DailyScheduleScreen extends StatefulWidget {
  final String universityName;

  const DailyScheduleScreen({required this.universityName});

  @override
  _DailyScheduleScreenState createState() => _DailyScheduleScreenState();
}

class _DailyScheduleScreenState extends State<DailyScheduleScreen> {
  late shamsi.Jalali _selectedDate;

  @override
  void initState() {
    super.initState();
    // Initialize with today's date in Jalali calendar
    _selectedDate = shamsi.Jalali.now();
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

  // Show custom Jalali date picker
  Future<void> _selectDate(BuildContext context) async {
    final shamsi.Jalali? picked = await showDialog<shamsi.Jalali>(
      context: context,
      builder: (context) => JalaliDatePickerDialog(
        initialDate: _selectedDate,
        onSelected: (date) {
          Navigator.pop(context, date);
        },
      ),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
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
                      icon: Icon(Icons.arrow_left, color: textColor),
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
                      icon: Icon(Icons.arrow_right, color: textColor),
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

// Custom Jalali Date Picker Dialog
class JalaliDatePickerDialog extends StatefulWidget {
  final shamsi.Jalali initialDate;
  final Function(shamsi.Jalali) onSelected;

  const JalaliDatePickerDialog({
    required this.initialDate,
    required this.onSelected,
  });

  @override
  _JalaliDatePickerDialogState createState() => _JalaliDatePickerDialogState();
}

class _JalaliDatePickerDialogState extends State<JalaliDatePickerDialog> {
  late int _year;
  late int _month;
  late int _day;
  final List<String> _months = [
    'فروردین',
    'اردیبهشت',
    'خرداد',
    'تیر',
    'مرداد',
    'شهریور',
    'مهر',
    'آبان',
    'آذر',
    'دی',
    'بهمن',
    'اسفند',
  ];
  final List<String> _daysOfWeek = [
    'ش',
    'ی',
    'د',
    'س',
    'چ',
    'پ',
    'ج',
  ];

  @override
  void initState() {
    super.initState();
    _year = widget.initialDate.year;
    _month = widget.initialDate.month;
    _day = widget.initialDate.day;
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final textColor = isDarkMode ? Colors.white : Colors.black;

    // Calculate the first day of the month and number of days
    final shamsi.Jalali firstDayOfMonth = shamsi.Jalali(_year, _month, 1);
    final int firstWeekday = (firstDayOfMonth.weekDay + 1) % 7; // Adjust for Persian week (starts Saturday)
    final int daysInMonth = firstDayOfMonth.monthLength;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        backgroundColor: isDarkMode ? const Color(0xFF383C4A) : Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_left, color: textColor),
              onPressed: () {
                setState(() {
                  if (_month == 12) {
                    _month = 1;
                    _year++;
                  } else {
                    _month++;
                  }
                  _day = 1; // Reset day to avoid invalid dates
                });
              },
            ),
            Text(
              '${_months[_month - 1]} $_year',
              style: TextStyle(
                color: textColor,
                fontFamily: 'Vazir',
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              icon: Icon(Icons.arrow_right, color: textColor),
              onPressed: () {
                setState(() {
                  if (_month == 1) {
                    _month = 12;
                    _year--;
                  } else {
                    _month--;
                  }
                  _day = 1; // Reset day to avoid invalid dates
                });
              },
            ),
          ],
        ),
        content: SizedBox(
          width: 300,
          height: 300,
          child: Column(
            children: [
              // Days of the week
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _daysOfWeek.map((day) {
                  return Text(
                    day,
                    style: TextStyle(
                      color: textColor,
                      fontFamily: 'Vazir',
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 10),
              // Calendar grid
              Expanded(
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    childAspectRatio: 1,
                  ),
                  itemCount: firstWeekday + daysInMonth,
                  itemBuilder: (context, index) {
                    if (index < firstWeekday) {
                      return const SizedBox.shrink();
                    }
                    final day = index - firstWeekday + 1;
                    final isSelected = day == _day;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _day = day;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.lightBlue : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            day.toString(),
                            style: TextStyle(
                              color: isSelected ? Colors.white : textColor,
                              fontFamily: 'Vazir',
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
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'لغو',
              style: TextStyle(
                color: Colors.lightBlue,
                fontFamily: 'Vazir',
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              final selected = shamsi.Jalali(_year, _month, _day);
              widget.onSelected(selected);
            },
            child: Text(
              'تأیید',
              style: TextStyle(
                color: Colors.lightBlue,
                fontFamily: 'Vazir',
              ),
            ),
          ),
        ],
      ),
    );
  }
}