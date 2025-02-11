import "package:animator_app/provider/planet_provider.dart";
import "package:animator_app/routes/routes.dart";
import "package:animator_app/screen/favourite/controller/fav_controller.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: PlanetsProvider()),
        ChangeNotifierProvider.value(value: FavouriteController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: Routes.routes,
      ),
    );
  }
}
