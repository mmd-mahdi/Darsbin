import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';
import '../theme_toggle_button.dart';
import '../widgets/SearchBarWidget.dart';
import '../schedule_service.dart';
import '../class_schedule.dart';

class FinalExamsScreen extends StatefulWidget {
  final String universityName;

  const FinalExamsScreen({required this.universityName});

  @override
  _FinalExamsScreenState createState() => _FinalExamsScreenState();
}

class _FinalExamsScreenState extends State<FinalExamsScreen> {
  String _searchQuery = '';
  List<ClassSchedule> _finalExamsData = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFinalExams();
  }

  Future<void> _loadFinalExams() async {
    final scheduleService = ScheduleService();
    final data = await scheduleService.loadScheduleData();
    setState(() {
      _finalExamsData = data
          .where((entry) =>
      entry.university == widget.universityName &&
          entry.finalExam != null)
          .toList();
      _isLoading = false;
    });
  }

  // Filtered data based on search query
  List<ClassSchedule> get filteredExams {
    if (_searchQuery.isEmpty) {
      return _finalExamsData;
    }
    return _finalExamsData
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
              // Page title
              SizedBox(height: 10),
              Center(
                child: Text(
                  'پایانترم ها',
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
                        DataColumn(
                          label: Text(
                            'تاریخ',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Vazir',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'ساعت',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Vazir',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'محل امتحان',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Vazir',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                      rows: filteredExams.map((entry) {
                        return DataRow(cells: [
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
                              entry.classCode,
                              style: TextStyle(
                                color: textColor,
                                fontFamily: 'Vazir',
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              entry.finalExam!.date,
                              style: TextStyle(
                                color: textColor,
                                fontFamily: 'Vazir',
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              entry.finalExam!.time,
                              style: TextStyle(
                                color: textColor,
                                fontFamily: 'Vazir',
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              entry.finalExam!.location,
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