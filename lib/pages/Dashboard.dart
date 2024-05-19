import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studentapp/pages/Fee.dart';
import 'package:studentapp/pages/Login.dart';
import 'package:studentapp/pages/Menu.dart';
import 'package:studentapp/pages/Notification.dart';
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

  final pages = [FeePage(), MenuPage(), NotificationPage()];

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
        title: Text("North Point Day School"),
        centerTitle: true,
        backgroundColor: mainColor,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
                accountName: Text(name),
                accountEmail: Text("Student Code: " + studentCode),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(imageUrl),
                )),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Father\'s Name",
                  style: TextStyle(fontWeight: FontWeight.w700)),
              subtitle: Text(fathers_name), // Close drawer on tap
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text(
                "Mother\'s Name",
                style: TextStyle(fontWeight: FontWeight.w700),
              ), // Close drawer on tap
              subtitle: Text(mothers_name), // Close drawer on tap
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text("Phone",
                  style: TextStyle(
                      fontWeight: FontWeight.w700)), // Close drawer on tap
              subtitle: Text(phone), // Close drawer on tap
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
            icon: Icon(Icons.home_outlined),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications,
            ),
            label: 'Notification',
          ),
        ],
      ),
    );
  }
}
