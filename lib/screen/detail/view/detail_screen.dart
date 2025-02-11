import 'dart:math';

import 'package:animator_app/model/model.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late AnimationController positionController;

  late Animation opacity;
  late Animation positionName;
  late Animation positionType;
  late Animation opacityDescp;

  bool isFavorite = false; // Variable to track if the item is a favorite

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();

    positionController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..forward();

    opacity = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.0,
          0.5,
          curve: Curves.easeInOut,
        ),
      ),
    );

    positionName = Tween(begin: 345.0, end: 0.0).animate(
      CurvedAnimation(
        parent: positionController,
        curve: const Interval(
          0.5,
          0.7,
          curve: Curves.easeInOut,
        ),
      ),
    );
    positionType = Tween(begin: -345.0, end: 0.0).animate(
      CurvedAnimation(
        parent: positionController,
        curve: const Interval(
          0.6,
          0.8,
          curve: Curves.easeInOut,
        ),
      ),
    );
    opacityDescp = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: positionController,
        curve: const Interval(
          0.8,
          1.0,
          curve: Curves.easeInOut,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SolarModel data = ModalRoute.of(context)!.settings.arguments as SolarModel;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black, Colors.blueGrey.shade900],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: AnimatedBuilder(
                  animation: animationController,
                  builder: (context, child) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              const Spacer(),
                              IconButton(
                                icon: Icon(
                                  isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: isFavorite ? Colors.red : Colors.white,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isFavorite =
                                        !isFavorite; // Toggle favorite status
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        Hero(
                          tag: "${data.name}",
                          child: Container(
                            height: 350,
                            width: 350,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blueGrey.shade900,
                                  blurRadius: 40,
                                  spreadRadius: 5,
                                ),
                              ],
                              image: DecorationImage(
                                image: AssetImage("${data.image}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        AnimatedBuilder(
                            animation: positionController,
                            builder: (context, child) {
                              return Opacity(
                                opacity: opacity.value,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  color: Colors.blueGrey.withOpacity(0.3),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Transform.translate(
                                          offset: Offset(positionName.value, 0),
                                          child: Text(
                                            "${data.name}",
                                            style: const TextStyle(
                                              fontSize: 28,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        Transform.translate(
                                          offset: Offset(positionType.value, 0),
                                          child: Text(
                                            "${data.type}",
                                            style: const TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 14),
                                        Opacity(
                                          opacity: opacityDescp.value,
                                          child: Column(
                                            children: [
                                              Text(
                                                "${data.description}",
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white70,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ],
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
