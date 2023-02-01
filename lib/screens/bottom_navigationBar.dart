import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shop_app/screens/order_screen.dart';

import 'cart_screen.dart';
import 'favorite_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';

class BottomNavigation extends StatefulWidget {
  static const routeName = '/bottom-navigation';
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  late List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {'page': HomeScreen()},
      {'page': FavoriteScreen()},
      {'page': ProfileScreen()},
    ];
    super.initState();
  }

  @override
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0xFFe8e8e8),
              blurRadius: 5.0,
              spreadRadius: 15,
              offset: Offset(0,5),
            ),
            BoxShadow(
              color: Colors.white,
              offset: Offset(-5,0)
            ),
            BoxShadow(
              color: Colors.white,
              offset: Offset(5,0)
            )
          ],
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: GNav(
              selectedIndex: _selectedPageIndex,
              onTabChange: _selectPage,
              tabBorderRadius: 15,
              curve: Curves.easeOutExpo, 
              duration: const Duration(milliseconds: 600),
              gap: 8,
              color: Colors.grey,
              activeColor: Colors.pink,
              iconSize: 20, 
              tabBackgroundColor:
                  Colors.pink.withOpacity(0.1),
              padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 10), 
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.favorite,
                  text: 'Favorite',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                )
              ]),
        ),
      ),
    );
  }
}
