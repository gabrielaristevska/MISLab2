import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/meal_model.dart';
import '../services/api_service.dart';

class MealDetailsPage extends StatefulWidget {
  final String? mealId;
  final bool isRandom;

  const MealDetailsPage({super.key, this.mealId, this.isRandom = false});

  @override
  State<MealDetailsPage> createState() => _MealDetailsPageState();
}

class _MealDetailsPageState extends State<MealDetailsPage> {
  Meal? _meal;
  bool _isLoading = true;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _loadMeal();
  }

  void _loadMeal() async {
    Meal? meal;
    if (widget.isRandom) {
      meal = await _apiService.loadRandomMeal();
    } else {
      meal = await _apiService.loadMealDetails(widget.mealId!);
    }
    setState(() {
      _meal = meal;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_meal?.strMeal ?? "Loading...")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(_meal!.strMealThumb),
            const SizedBox(height: 16),
            Text(
              _meal!.strMeal,
              style: const TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text("Instructions:",
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold)),
            Text(_meal!.strInstructions!),
            const SizedBox(height: 16),
            Text("Ingredients:",
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold)),
            ..._meal!.ingredients!.map((ing) => Text("• $ing")),
            const SizedBox(height: 16),
            if (_meal!.strYoutube != null &&
                _meal!.strYoutube!.isNotEmpty)
              TextButton(
                onPressed: () =>
                    launchUrl(Uri.parse(_meal!.strYoutube!)),
                child: const Text("Watch on YouTube"),
              ),
          ],
        ),
      ),
    );
  }
}
