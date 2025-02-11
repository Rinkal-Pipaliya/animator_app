import 'dart:convert';

import 'package:animator_app/model/model.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SolarHelper {
  static SolarHelper helper = SolarHelper._();
  SolarHelper._();

  Future<List<SolarModel>> getPlanet() async {
    String jsonPlanetsData =
        await rootBundle.loadString('assets/json/solar.json');
    List planets = jsonDecode(jsonPlanetsData);
    List<SolarModel> planetsList =
        planets.map((e) => SolarModel.mapToModel(e)).toList();
    return planetsList;
  }

  static const String themeKey = "themeKey";

  setTheme(bool val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(themeKey, val);
  }

  getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getBool(themeKey);
  }
}
