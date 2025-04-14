import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';
import 'university_dashboard_screen.dart';
import '../theme_toggle_button.dart';
import '../schedule_service.dart';
import '../class_schedule.dart';

class UniversitySelectionScreen extends StatefulWidget {
  @override
  _UniversitySelectionScreenState createState() => _UniversitySelectionScreenState();
}

class _UniversitySelectionScreenState extends State<UniversitySelectionScreen> {
  List<String> universities = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUniversities();
  }

  Future<void> _loadUniversities() async {
    final scheduleService = ScheduleService();
    final data = await scheduleService.loadScheduleData();
    setState(() {
      universities = data.map((entry) => entry.university).toSet().toList();
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final textColor = themeProvider.isDarkMode ? Colors.white : Color(0xff4a4a4a);
    final backgroundColor = themeProvider.isDarkMode ? Color(0xFF383C4A) : Colors.white;

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
                    SizedBox(width: 48), // Placeholder to balance the row on the left
                    Expanded(
                      child: SizedBox(), // Empty space to push ThemeToggleButton to the right
                    ),
                     // Moved to the top right
                  ],
                ),
              ),
              // Fixed header section
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      width: 150,
                      height: 150,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'سامانه درس بین',
                      style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Vazir',
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'انتخاب دانشگاه:',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Vazir',
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              // Scrollable university list
              Expanded(
                child: _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                  itemCount: universities.length,
                  itemBuilder: (context, index) {
                    return Center(
                      child: UniversityButton(
                        universityName: universities[index],
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) =>
                                  UniversityDashboardScreen(
                                    universityName: universities[index],
                                  ),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                              transitionDuration: Duration(milliseconds: 300),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UniversityButton extends StatelessWidget {
  final String universityName;
  final VoidCallback onTap;

  const UniversityButton({
    required this.universityName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      margin: EdgeInsets.only(bottom: 20),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.lightBlue,
          padding: EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          universityName,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontFamily: 'Vazir',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}