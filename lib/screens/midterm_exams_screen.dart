import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';
import '../theme_toggle_button.dart';
import '../widgets/SearchBarWidget.dart';

class MidtermExamsScreen extends StatefulWidget {
  final String universityName;

  const MidtermExamsScreen({required this.universityName});

  @override
  _MidtermExamsScreenState createState() => _MidtermExamsScreenState();
}

class _MidtermExamsScreenState extends State<MidtermExamsScreen> {
  String _searchQuery = '';

  // Sample data for midterm exams (List<Map<String, String>> format)
  final List<Map<String, String>> midtermExamsData = [
    {
      'className': 'ریاضی عمومی',
      'classCode': 'م',
      'date': '۱۴۰۴/۰۳/۱۰',
      'time': '۱۰:۰۰',
      'location': 'کلاس ۱۰۱',
    },
    {
      'className': 'فیزیک',
      'classCode': 'م',
      'date': '۱۴۰۴/۰۳/۱۲',
      'time': '۱۴:۰۰',
      'location': 'کلاس ۱۰۲',
    },
    {
      'className': 'برنامه نویسی',
      'classCode': 'م',
      'date': '۱۴۰۴/۰۳/۱۴',
      'time': '۹:۰۰',
      'location': 'کلاس ۱۰۳',
    },
    {
      'className': 'شیمی عمومی',
      'classCode': 'م',
      'date': '۱۴۰۴/۰۳/۱۶',
      'time': '۱۱:۰۰',
      'location': 'کلاس ۱۰۴',
    },
    {
      'className': 'مدارهای الکتریکی',
      'classCode': 'م',
      'date': '۱۴۰۴/۰۳/۱۸',
      'time': '۱۵:۰۰',
      'location': 'کلاس ۱۰۵',
    },
  ];

  // Filtered data based on search query
  List<Map<String, String>> get filteredExams {
    if (_searchQuery.isEmpty) {
      return midtermExamsData;
    }
    return midtermExamsData.where((entry) {
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
              // Page title
              SizedBox(height: 10),
              Center(
                child: Text(
                  'میانترم ها',
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
                          DataCell(
                            Text(
                              entry['date']!,
                              style: TextStyle(
                                color: textColor,
                                fontFamily: 'Vazir',
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              entry['time']!,
                              style: TextStyle(
                                color: textColor,
                                fontFamily: 'Vazir',
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              entry['location']!,
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