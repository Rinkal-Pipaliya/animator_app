import 'dart:math';
import 'package:animator_app/provider/planet_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;

  late PlanetsProvider providerW;
  late PlanetsProvider providerR;
  late AnimationController animationController;

  late Animation rotate;

  @override
  void initState() {
    super.initState();
    context.read<PlanetsProvider>().getPlanet();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat();

    rotate = Tween(begin: 0.0, end: pi * 2).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    providerW = context.watch<PlanetsProvider>();
    providerR = context.read<PlanetsProvider>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Galaxy",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            if (providerW.planets.isNotEmpty) {
              setState(() {
                Navigator.of(context).pushNamed(
                  'detail_page',
                  arguments: providerW.planets[currentIndex],
                );
              });
            }
          },
          icon: const Icon(Icons.arrow_forward_ios),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/favourite');
            },
            icon: const Icon(Icons.favorite_border, color: Colors.white),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.75),
                  BlendMode.darken,
                ),
                image: const AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0.5, 0.8),
            child: AnimatedDefaultTextStyle(
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              duration: const Duration(milliseconds: 350),
              child: Text(
                "${providerW.planets[currentIndex].name}",
              ),
            ),
          ),
          ListWheelScrollView.useDelegate(
            itemExtent: 280,
            physics: const FixedExtentScrollPhysics(),
            offAxisFraction: 1.4,
            onSelectedItemChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            squeeze: 0.69,
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: providerW.planets.length,
              builder: (context, index) => AnimatedBuilder(
                animation: animationController,
                builder: (context, child) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/detail',
                          arguments: providerW.planets[index]);
                    },
                    child: Transform.rotate(
                      angle: rotate.value,
                      child: Hero(
                        tag: "${providerW.planets[index].name}",
                        child: Image.asset(
                          "${providerW.planets[index].image}",
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
