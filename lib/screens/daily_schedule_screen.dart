import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamsi_date/shamsi_date.dart' as shamsi;
import '../theme_provider.dart';
import '../theme_toggle_button.dart';
import '../schedule_service.dart';
import '../class_schedule.dart';

class DailyScheduleScreen extends StatefulWidget {
  final String universityName;

  const DailyScheduleScreen({required this.universityName});

  @override
  _DailyScheduleScreenState createState() => _DailyScheduleScreenState();
}

class _DailyScheduleScreenState extends State<DailyScheduleScreen> {
  late shamsi.Jalali _selectedDate;
  List<ClassSchedule> _scheduleData = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Initialize with today's date in Jalali calendar
    _selectedDate = shamsi.Jalali.now();
    _loadScheduleData();
  }

  Future<void> _loadScheduleData() async {
    final scheduleService = ScheduleService();
    final data = await scheduleService.loadScheduleData();
    setState(() {
      _scheduleData = data.where((entry) => entry.university == widget.universityName).toList();
      _isLoading = false;
    });
  }

  // Filter data by selected date
  List<ClassSchedule> get _filteredSchedule {
    final selectedDateStr =
        '${_selectedDate.year}/${_selectedDate.month.toString().padLeft(2, '0')}/${_selectedDate.day.toString().padLeft(2, '0')}';
    return _scheduleData.where((entry) => entry.classDate == selectedDateStr).toList();
  }

  // Helper method to convert weekDay integer to Persian day name
  String _getPersianDayName(int weekDay) {
    const List<String> days = [
      'شنبه',   // 1
      'یکشنبه', // 2
      'دوشنبه', // 3
      'سه‌شنبه', // 4
      'چهارشنبه', // 5
      'پنج‌شنبه', // 6
      'جمعه',   // 7
    ];
    return days[weekDay - 1];
  }

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
    };
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
              // Theme toggle button

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
                child: _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
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
                            'نام استاد',
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
                            'کد درس',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Vazir',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                      rows: _filteredSchedule.map((entry) {
                        final weekDay = shamsi.Jalali.fromDateTime(
                          DateTime.parse('${entry.classDate.replaceAll('/', '-')}T00:00:00Z'),
                        ).weekDay;
                        final dayName = _getPersianDayName(weekDay);
                        return DataRow(cells: [
                          DataCell(
                            Text(
                              dayName,
                              style: TextStyle(
                                color: textColor,
                                fontFamily: 'Vazir',
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              entry.className,
                              style: TextStyle(
                                color: textColor,
                                fontFamily: 'Vazir',
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              entry.professorName,
                              style: TextStyle(
                                color: textColor,
                                fontFamily: 'Vazir',
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              entry.classTime.start,
                              style: TextStyle(
                                color: textColor,
                                fontFamily: 'Vazir',
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              entry.classTime.end,
                              style: TextStyle(
                                color: textColor,
                                fontFamily: 'Vazir',
                              ),
                            ),
                          ),

                          DataCell(
                            Text(
                              entry.classCode,
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

// Custom Jalali Date Picker Dialog (unchanged)
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