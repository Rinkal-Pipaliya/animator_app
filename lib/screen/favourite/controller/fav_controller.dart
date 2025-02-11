import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteController extends ChangeNotifier {
  List<String> favoriteList = [];
  SharedPreferences? shr;

  addFavourite({required String name}) {
    if (favoriteList.contains(name)) {
      favoriteList.remove(name);
    } else {
      favoriteList.add(name);
    }
    shr?.setStringList('allfavouriteplanets', favoriteList);
    notifyListeners();
  }

  bool checkStatus({required String name}) {
    if (favoriteList.contains(name)) {
      return true;
    } else {
      return false;
    }
  }

  get getAllFavourite {
    favoriteList = shr?.getStringList('allfavouriteplanets') ?? [];
    return favoriteList;
  }
}
