import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'input_screen.dart';
import 'saved_schedules_screen.dart';
import 'settings_screen.dart';

/// Main home screen with bottom navigation
class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  static final navigatorKey = GlobalKey<_HomeScreenNavigatorState>();

  @override
  Widget build(BuildContext context) {
    return _HomeScreenNavigator(key: HomeScreen.navigatorKey);
  }
}

class _HomeScreenNavigator extends StatefulWidget {
  const _HomeScreenNavigator({super.key});

  @override
  State<_HomeScreenNavigator> createState() => _HomeScreenNavigatorState();
}

class _HomeScreenNavigatorState extends State<_HomeScreenNavigator> {
  int currentIndex = 1;

  void navigateToTab(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      const SavedSchedulesScreen(),
      const InputScreen(),
      const SettingsScreen(),
    ];

    return Scaffold(
      body: IndexedStack(index: currentIndex, children: screens),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          navigateToTab(index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.save_outlined),
            selectedIcon: Icon(Icons.save),
            label: 'Saved',
          ),
          NavigationDestination(
            icon: Icon(Icons.edit_outlined),
            selectedIcon: Icon(Icons.edit),
            label: 'Input',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
