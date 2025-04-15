import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamsi_date/shamsi_date.dart' as shamsi;
import '../theme_provider.dart';
import '../theme_toggle_button.dart';
import '../widgets/SearchBarWidget.dart';
import '../schedule_service.dart';
import '../class_schedule.dart';

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
  List<ClassSchedule> _professorClasses = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProfessorClasses();
  }

  Future<void> _loadProfessorClasses() async {
    final scheduleService = ScheduleService();
    final data = await scheduleService.loadScheduleData();
    setState(() {
      _professorClasses = data
          .where((entry) =>
      entry.university == widget.universityName &&
          entry.professorName == widget.professorName)
          .toList();
      _isLoading = false;
    });
  }

  // Helper method to convert weekDay integer to Persian day name
  String _getPersianDayName(String classDate) {
    final weekDay = shamsi.Jalali.fromDateTime(
      DateTime.parse('${classDate.replaceAll('/', '-')}T00:00:00Z'),
    ).weekDay;
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

  // Filtered data based on search query
  List<ClassSchedule> get filteredClasses {
    if (_searchQuery.isEmpty) {
      return _professorClasses;
    }
    return _professorClasses
        .where((entry) => entry.className.contains(_searchQuery))
        .toList();
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
                      rows: filteredClasses.map((entry) {
                        final dayName = _getPersianDayName(entry.classDate);
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