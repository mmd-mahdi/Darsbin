import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'کلاس های جبرانی',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Vazir', // Persian font
      ),
      home: const CompensatoryClassesPage(),
    );
  }
}

class CompensatoryClassesPage extends StatefulWidget {
  const CompensatoryClassesPage({super.key});

  @override
  State<CompensatoryClassesPage> createState() => _CompensatoryClassesPageState();
}

class _CompensatoryClassesPageState extends State<CompensatoryClassesPage> {
  final List<Map<String, String>> _classes = [
    {"day": "شنبه", "teacher": "رستمی", "course": "الگوریتم", "code": "1"},
    {"day": "یکشنبه", "teacher": "صحافی زاده", "course": "ساختمان داده", "code": "2"},
    {"day": "دو شنبه", "teacher": "طاعتیان", "course": "پایگاه داده", "code": "3"},
    {"day": "سه شنبه", "teacher": "باغملاپی", "course": "زبان تخصصی", "code": "4"},
    {"day": "چهارشنبه", "teacher": "خیاطی", "course": "شبکه", "code": "5"},
    {"day": "شنبه", "teacher": "رستمی", "course": "الگوریتم", "code": "1"},
    {"day": "یکشنبه", "teacher": "صحافی زاده", "course": "ساختمان داده", "code": "2"},
    {"day": "یکشنبه", "teacher": "صحافی زاده", "course": "ساختمان داده", "code": "2"},
    {"day": "یکشنبه", "teacher": "صحافی زاده", "course": "ساختمان داده", "code": "2"},
    {"day": "یکشنبه", "teacher": "صحافی زاده", "course": "ساختمان داده", "code": "2"},
    {"day": "یکشنبه", "teacher": "صحافی زاده", "course": "ساختمان داده", "code": "2"},
    {"day": "یکشنبه", "teacher": "صحافی زاده", "course": "ساختمان داده", "code": "2"},
    {"day": "یکشنبه", "teacher": "صحافی زاده", "course": "ساختمان داده", "code": "2"},
    {"day": "یکشنبه", "teacher": "صحافی زاده", "course": "ساختمان داده", "code": "2"},
    {"day": "یکشنبه", "teacher": "صحافی زاده", "course": "ساختمان داده", "code": "2"},
    {"day": "یکشنبه", "teacher": "صحافی زاده", "course": "ساختمان داده", "code": "2"},
    {"day": "یکشنبه", "teacher": "صحافی زاده", "course": "ساختمان داده", "code": "2"},
  ];

  List<Map<String, String>> _filteredClasses = [];
  final TextEditingController _searchController = TextEditingController();
  final Color backgroundColor = const Color(0xFF424450);
  final Color headerColor = const Color(0xFF02AFF3);
  final Color textColor = Colors.white;
  final Color gridColor = Colors.black;
  final double cellPadding = 12.0;
  final double borderWidth = 1.0;

  @override
  void initState() {
    super.initState();
    _filteredClasses = List.from(_classes);
    _searchController.addListener(_filterClasses);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterClasses() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredClasses = _classes.where((cls) {
        return cls['day']!.toLowerCase().contains(query) ||
            cls['teacher']!.toLowerCase().contains(query) ||
            cls['course']!.toLowerCase().contains(query) ||
            cls['code']!.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('کلاس های جبرانی',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: backgroundColor,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          color: backgroundColor,
          padding: const EdgeInsets.all(35.0),
          child: Column(
            children: [
              // Search Bar with icon only on left
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: TextField(
                  controller: _searchController,
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                    hintText: '',
                    prefixIcon: null,
                    suffixIcon: Icon(Icons.search, color: Colors.grey[700]),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                  ),
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(height: 16.0),
              
              // Make the table horizontally scrollable with visible scrollbar
              Expanded(
                child: Scrollbar(
                  thumbVisibility: true, // Always show the scrollbar
                  trackVisibility: true, // Show track as well
                  thickness: 8.0, // Make scrollbar thicker
                  radius: const Radius.circular(4), // Rounded corners
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Table Header - RTL layout
                          Container(
                            decoration: BoxDecoration(
                              color: headerColor,
                              border: Border.all(color: gridColor, width: borderWidth),
                            ),
                            child: Row(
                              textDirection: TextDirection.rtl,
                              children: [
                                _buildHeaderCell('روز', flex: 2),
                                _buildHeaderCell('نام استاد', flex: 2),
                                _buildHeaderCell('نام درس', flex: 2),
                                _buildHeaderCell('کد درس', flex: 1, isLast: true),
                              ],
                            ),
                          ),
                          
                          // Table Content with vertical scrolling and scrollbar
                          Expanded(
                            child: Scrollbar(
                              thumbVisibility: true,
                              trackVisibility: true,
                              thickness: 8.0,
                              radius: const Radius.circular(4),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                itemCount: _filteredClasses.length,
                                itemBuilder: (context, index) {
                                  final cls = _filteredClasses[index];
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: backgroundColor,
                                      border: Border.all(color: gridColor, width: borderWidth),
                                    ),
                                    child: Row(
                                      textDirection: TextDirection.rtl,
                                      children: [
                                        _buildDataCell(cls['day']!, flex: 2),
                                        _buildDataCell(cls['teacher']!, flex: 2),
                                        _buildDataCell(cls['course']!, flex: 2),
                                        _buildDataCell(cls['code']!, flex: 1, isLast: true),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
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

  Widget _buildHeaderCell(String text, {int flex = 1, bool isLast = false}) {
    return Expanded(
      flex: flex,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          border: Border(
            left: isLast 
                ? BorderSide.none 
                : BorderSide(color: gridColor, width: borderWidth),
          ),
        ),
        padding: EdgeInsets.all(cellPadding),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDataCell(String text, {int flex = 1, bool isLast = false}) {
    return Expanded(
      flex: flex,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          border: Border(
            left: isLast 
                ? BorderSide.none 
                : BorderSide(color: gridColor, width: borderWidth),
          ),
        ),
        padding: EdgeInsets.all(cellPadding),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}