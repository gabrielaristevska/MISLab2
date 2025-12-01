import 'package:flutter/material.dart';
import '../models/meal_model.dart';
import '../widgets/meal_card.dart';

class FavoritesPage extends StatelessWidget {
  final List<Meal> favorites;
  final Function(Meal) onFavoriteToggle;

  const FavoritesPage({
    super.key,
    required this.favorites,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favorite Recipes")),
      body: favorites.isEmpty
          ? const Center(
        child: Text(
          "No favorites yet",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final meal = favorites[index];
          return MealCard(
            meal: meal,
            isFavorite: true,
            onFavoriteToggle: () => onFavoriteToggle(meal),
          );
        },
      ),
    );
  }
}
