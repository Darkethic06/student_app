import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studentapp/pages/Fee.dart';
import 'package:studentapp/pages/Login.dart';
import 'package:studentapp/pages/Menu.dart';
import 'package:studentapp/pages/Notification.dart';
import 'package:studentapp/pages/Profile.dart';
import 'package:studentapp/utils/myColors.dart';
import 'package:http/http.dart' as http;

import '../utils/api.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 1;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final pages = [FeePage(), MenuPage(), ProfilePage()];

  // String apiResponse = '';
  String name = '';
  String email = '';
  String studentCode = '';
  String phone = '';
  String fathers_name = '';
  String mothers_name = '';
  String imageUrl = '';

  Future<void> fetchProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final uri = Uri.parse('$basePath/user');
    final headers = {'Authorization': 'Bearer $token'};
    final response = await http.get(uri, headers: headers);

    final data = jsonDecode(response.body);
    setState(() {
      name = data['data']['full_name'];
      studentCode = data['data']['student_code'];
      phone = data['data']['phone'];
      fathers_name = data['data']['fathers_name'];
      mothers_name = data['data']['mothers_name'];
      imageUrl = data['data']['profile_photo_url'];
    });
  }

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "North Point Day School",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: mainColor,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Boxicons.bxs_bell_ring))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
              decoration: BoxDecoration(color: mainColor),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40.0,
                    backgroundImage: NetworkImage(imageUrl),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            name,
                            // "Hello",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0, // Adjust font size as needed
                              fontWeight:
                                  FontWeight.bold, // Make name bold (optional)
                            ),
                          ),
                          Text(
                            "Student Code: $studentCode",

                            style: TextStyle(
                                fontSize: 14.0,
                                color:
                                    Colors.white), // Adjust font size as needed
                          ),
                          // Add your additional text widget here
                          Text(
                            "Additional Text", // Replace with your text content
                            style: TextStyle(
                                fontSize: 14.0,
                                color:
                                    Colors.white), // Adjust font size as needed
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            ListTile(
              leading: Container(
                padding: EdgeInsets.all(8.0), // Adjust padding as needed
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: mainColor, // Change background color as desired
                ),
                child: Icon(
                  Boxicons.bxs_bell_ring,
                  color: Colors.white,
                ),
              ),
              title: Text("Notice",
                  style: TextStyle(
                      fontWeight: FontWeight.w700)), // Close drawer on tap
            ),
            ListTile(
              leading: Container(
                padding: EdgeInsets.all(8.0), // Adjust padding as needed
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: mainColor, // Change background color as desired
                ),
                child: Icon(
                  Icons.school_rounded,
                  color: Colors.white,
                ),
              ),
              title: Text(
                "Attendance",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            ListTile(
              leading: Container(
                padding: EdgeInsets.all(8.0), // Adjust padding as needed
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: mainColor, // Change background color as desired
                ),
                child: Icon(
                  Boxicons.bx_alarm,
                  color: Colors.white,
                ),
              ),
              title: Text("Exam",
                  style: TextStyle(
                      fontWeight: FontWeight.w700)), // Close drawer on tap
              // Close drawer on tap
            ),
            ListTile(
              leading: Container(
                padding: EdgeInsets.all(8.0), // Adjust padding as needed
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: mainColor, // Change background color as desired
                ),
                child: Icon(
                  Icons.edit_note_rounded,
                  color: Colors.white,
                ),
              ),
              title: Text("Assignment",
                  style: TextStyle(
                      fontWeight: FontWeight.w700)), // Close drawer on tap
              // Close drawer on tap
            ),
            ListTile(
              leading: Container(
                padding: EdgeInsets.all(8.0), // Adjust padding as needed
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: mainColor, // Change background color as desired
                ),
                child: Icon(
                  Icons.collections_bookmark_rounded,
                  color: Colors.white,
                ),
              ),
              title: Text("Syllabus",
                  style: TextStyle(
                      fontWeight: FontWeight.w700)), // Close drawer on tap
              // Close drawer on tap
            ),
            ListTile(
              leading: Container(
                padding: EdgeInsets.all(8.0), // Adjust padding as needed
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: mainColor, // Change background color as desired
                ),
                child: Icon(
                  Boxicons.bx_user,
                  color: Colors.white,
                ),
              ),
              title: Text("Teachers",
                  style: TextStyle(
                      fontWeight: FontWeight.w700)), // Close drawer on tap
              // Close drawer on tap
            ),
            ListTile(
              leading: Container(
                padding: EdgeInsets.all(8.0), // Adjust padding as needed
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: mainColor, // Change background color as desired
                ),
                child: Icon(
                  Icons.group,
                  color: Colors.white,
                ),
              ),
              title: Text("Classmates",
                  style: TextStyle(
                      fontWeight: FontWeight.w700)), // Close drawer on tap
              // Close drawer on tap
            ),
            ListTile(
              leading: Container(
                padding: EdgeInsets.all(8.0), // Adjust padding as needed
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: mainColor, // Change background color as desired
                ),
                child: Icon(
                  Icons.cast_for_education,
                  color: Colors.white,
                ),
              ),
              title: Text("Report Card",
                  style: TextStyle(
                      fontWeight: FontWeight.w700)), // Close drawer on tap
              // Close drawer on tap
            ),
            ListTile(
              leading: Container(
                padding: EdgeInsets.all(8.0), // Adjust padding as needed
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: mainColor, // Change background color as desired
                ),
                child: Icon(
                  Icons.image,
                  color: Colors.white,
                ),
              ),
              title: Text("Gallery",
                  style: TextStyle(
                      fontWeight: FontWeight.w700)), // Close drawer on tap
              // Close drawer on tap
            ),
            ListTile(
              leading: Container(
                padding: EdgeInsets.all(8.0), // Adjust padding as needed
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: mainColor, // Change background color as desired
                ),
                child: Icon(
                  Icons.beach_access,
                  color: Colors.white,
                ),
              ),
              title: Text("Holiday",
                  style: TextStyle(
                      fontWeight: FontWeight.w700)), // Close drawer on tap
              // Close drawer on tap
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.clear();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              }, // Close drawer on tap
            ),
          ],
        ),
      ),
      body: Center(child: pages.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: btnColor,
        unselectedItemColor: mainColor,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(
          color: Colors.red,
        ),
        unselectedLabelStyle: TextStyle(
          color: mainColor,
        ),
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_rounded),
            label: 'Fee',
          ),
          BottomNavigationBarItem(
            icon: Icon(Boxicons.bxs_dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Boxicons.bxs_user,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
