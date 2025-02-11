import 'package:animator_app/screen/detail/view/detail_screen.dart';
import 'package:animator_app/screen/favourite/view/favourite_screen.dart';
import 'package:animator_app/screen/home/view/home_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String home = '/';

  static const String detail = '/detail';
  static const String favourite = '/favourite';

  static Map<String, Widget Function(BuildContext)> routes = {
    Routes.home: (_) => const HomeScreen(),
    Routes.detail: (_) => const DetailScreen(),
    Routes.favourite: (_) => const FavouriteScreen(),
  };
}
