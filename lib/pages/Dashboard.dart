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

  final pages = [MenuPage(), HomePage(), NotificationPage(), FeePage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            icon: Icon(
              Icons.menu_sharp,
            ),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications,
            ),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_rounded),
            label: 'Fee',
          ),
        ],
      ),
    );
  }
}
