import 'package:flutter/material.dart';
import 'package:lab_2/screens/favourites.dart';
import 'package:lab_2/screens/foods_by_category.dart';
import 'package:lab_2/screens/home.dart';
import 'package:lab_2/screens/meals_details.dart';

import 'models/category_model.dart';
import 'models/meal_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  debugPrint("📩 Background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
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
        "/favorites": (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map;
          final favorites = args["favorites"] as List<Meal>;
          final onFavoriteToggle = args["onFavoriteToggle"] as Function(Meal);
          return FavoritesPage(favorites: favorites, onFavoriteToggle: onFavoriteToggle);
        },
      },
    );
  }
}

