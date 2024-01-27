import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../router/app_routes.dart';

@RoutePage()
class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        HomeRoute(),
        CityRoute(),
        SettingsRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) => buildBottomBar(tabsRouter),
    );
  }

  Widget buildBottomBar(TabsRouter tabsRouter) {
    return BottomNavigationBar(
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.black,
      unselectedLabelStyle: const TextStyle(color: Colors.black),
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Symbols.location_city), label: 'Cities'),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings), label: 'Settings'),
      ],
      currentIndex: tabsRouter.activeIndex,
      onTap: (index) {
        setState(() {
          tabsRouter.setActiveIndex(index);
        });
      },
    );
  }
}
