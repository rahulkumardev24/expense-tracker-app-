import 'package:expense_tracker_app/Colors.dart';
import 'package:expense_tracker_app/screen/home_screen.dart';
import 'package:expense_tracker_app/screen/static_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentScreen = 0;

  final List<Widget> screens = [
    const HomeScreen(),
    const StaticScreen(),
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      currentScreen = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentScreen],
      bottomNavigationBar: myBottomNavigations(context),
    );
  }

  Widget myBottomNavigations(BuildContext context) {
    return Container(
      height: 90,
      decoration: const BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(width: 2, color: AppColors.lightSky),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(color: AppColors.lightSky),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              navItem(
                const Icon(
                  Icons.home_filled,
                  size: 40,
                ),
                0,
              ),
              navItem(
                const Icon(
                  Icons.align_vertical_bottom_rounded,
                  size: 40,
                ),
                1,
              ),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.pink.shade400 ,
                ),

                child: navItem(
                  const Icon(
                    Icons.add,
                    size: 40,
                  ),
                  2,
                ),
              ),
              navItem(
                const Icon(
                  Icons.notifications_active,
                  size: 40,
                ),
                3,
              ),
              navItem(
                const Icon(
                  Icons.workspace_premium,
                  size: 40,
                ),
                4,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget navItem(Icon icon, int index) {
    return InkWell(
      onTap: () => _onItemTapped(index),
      child: SizedBox(
        child: Icon(
          icon.icon,
          size: icon.size,
          color: index == currentScreen ? Colors.pink : Colors.black54,
        ),
      ),
    );
  }
}
