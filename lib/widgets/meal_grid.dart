import 'package:flutter/material.dart';
import '../models/meal_model.dart';
import 'meal_card.dart';

class MealGrid extends StatelessWidget {
  final List<Meal> meals;
  final List<Meal> favorites;
  final Function(Meal) onFavoriteToggle;

  const MealGrid({
    super.key,
    required this.meals,
    required this.favorites,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: meals.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) {
        final meal = meals[index];
        final isFav = favorites.contains(meal);

        return MealCard(
          meal: meal,
          isFavorite: isFav,
          onFavoriteToggle: () => onFavoriteToggle(meal),
        );
      },
    );
  }
}
