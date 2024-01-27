import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../ui/city_screen.dart';
import '../ui/home_screen.dart';
import '../ui/main_screen.dart';
import '../ui/settings_screen.dart';

part 'app_routes.gr.dart';

/// This is a very simple router and probably not needed for this simple of an app.
/// However, it is a good example of how to use the AutoRoute package.
@AutoRouterConfig()
class AppRouter extends _$AppRouter {

  AppRouter();


  @override
  List<AutoRoute> get routes => [
    AutoRoute(path: '/', page: MainRoute.page, initial: true, children: [
      AutoRoute(path: 'home', page: HomeRoute.page),
      AutoRoute(path: 'cities', page: CityRoute.page),
      AutoRoute(path: 'settings', page: SettingsRoute.page),
    ]),
  ];

}
