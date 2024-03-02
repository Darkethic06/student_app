import 'package:flutter/material.dart';
import 'package:studentapp/pages/Fee.dart';
import 'package:studentapp/pages/HomePage.dart';
import 'package:studentapp/pages/Menu.dart';
import 'package:studentapp/pages/Notification.dart';
import 'package:studentapp/utils/myColors.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("North Point Day School"),
        centerTitle: true,
        backgroundColor: mainColor,
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
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
