import 'package:flutter/material.dart';
import '../models/meal_model.dart';
import '../services/api_service.dart';
import '../widgets/meal_grid.dart';

class FoodsByCategoryPage extends StatefulWidget {
  final String category;
  const FoodsByCategoryPage({super.key, required this.category});

  @override
  State<FoodsByCategoryPage> createState() => _FoodsByCategoryPageState();
}

class _FoodsByCategoryPageState extends State<FoodsByCategoryPage> {
  List<Meal> _meal = [];
  List<Meal> _filteredMeals = [];
  bool _isLoading = true;
  bool _isSearching = false;
  String _searchQuery = '';
  final ApiService _apiService = ApiService();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadMeals();
  }

  void _loadMeals() async {
    final mealList = await _apiService.loadMealsByCategory(widget.category);
    setState(() {
      _meal = mealList;
      _filteredMeals = mealList;
      _isLoading = false;
    });
  }

  void _filterMeals(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredMeals = _meal;
      } else {
        _filteredMeals = _meal
            .where((m) => m.strMeal.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  Future<void> _searchMealByName(String name) async {
    if (name.isEmpty) return;
    setState(() => _isSearching = true);

    final meal = await _apiService.searchMealByName(name);

    setState(() {
      _isSearching = false;
      if (meal != null) {
        _filteredMeals = [meal];
      } else {
        _filteredMeals = [];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Meals: ${widget.category}")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search meal by name...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: _filterMeals,
            ),
          ),
          Expanded(
            child: _filteredMeals.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.search_off,
                      size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text('No meals found',
                      style: TextStyle(
                          fontSize: 18, color: Colors.grey)),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: _isSearching
                        ? null
                        : () => _searchMealByName(_searchQuery),
                    child: _isSearching
                        ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                          strokeWidth: 2),
                    )
                        : const Text('Search in API'),
                  ),
                ],
              ),
            )
                : Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 12),
              child: MealGrid(meals: _filteredMeals),
            ),
          ),
        ],
      ),
    );
  }
}
