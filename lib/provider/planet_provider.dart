import 'package:animator_app/helper/solar_helper.dart';
import 'package:animator_app/model/model.dart';
import 'package:flutter/material.dart';

class PlanetsProvider with ChangeNotifier {
  List<SolarModel> planets = [];

  void getPlanet() async {
    planets = await SolarHelper.helper.getPlanet();
    notifyListeners();
  }
}
