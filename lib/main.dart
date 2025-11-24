import 'package:flutter/material.dart';
import 'package:lab_2/screens/foods_by_category.dart';
import 'package:lab_2/screens/home.dart';
import 'package:lab_2/screens/meals_details.dart';

import 'models/category_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const MyHomePage(title: 'Food App'),
        "/foodsByCategory": (context) {
          final category = ModalRoute.of(context)!.settings.arguments as FoodCategory;
          return FoodsByCategoryPage(category: category.strCategory);
        },
        "/mealDetails": (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map?;
          final isRandom = args?["isRandom"] ?? false;
          final mealId = args?["mealId"];
          return MealDetailsPage(mealId: mealId, isRandom: isRandom);
        },
      },
    );
  }
}

