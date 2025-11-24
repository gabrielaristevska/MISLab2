import 'package:flutter/material.dart';
import '../models/meal_model.dart';

class MealCard extends StatelessWidget {
  final Meal meal;

  const MealCard({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          "/mealDetails",
          arguments: {"mealId": meal.idMeal},
        );
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              meal.strMealThumb,
              height: 150,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.broken_image,
                  size: 50, color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                meal.strMeal,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                softWrap: true,
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
