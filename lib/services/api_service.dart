import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category_model.dart';
import '../models/meal_model.dart';

class ApiService {

  Future<List<FoodCategory>> loadCategories() async {
    List<FoodCategory> categoryList = [];

    final response = await http.get(
      Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      for (var item in data['categories']) {
        categoryList.add(FoodCategory.fromJson(item));
      }
    }

    return categoryList;
  }

  Future<List<Meal>> loadMealsByCategory(String category) async {
    List<Meal> mealList = [];
    final response = await http.get(
      Uri.parse('https://www.themealdb.com/api/json/v1/1/filter.php?c=$category'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      for (var item in data['meals']) {
        mealList.add(Meal.fromJson(item));
      }
    }

    return mealList;
  }

  Future<Meal?> searchMealByName(String name) async {
    final response = await http.get(
      Uri.parse('https://www.themealdb.com/api/json/v1/1/search.php?s=$name'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['meals'] != null) {
        return Meal.fromJson(data['meals'][0]);
      }
    }
    return null;
  }

  Future<Meal?> loadMealDetails(String id) async {
    final response = await http.get(
      Uri.parse('https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['meals'] != null) {
        return Meal.fromJson(data['meals'][0]);
      }
    }
    return null;
  }

  Future<Meal?> loadRandomMeal() async {
    final response = await http.get(
      Uri.parse('https://www.themealdb.com/api/json/v1/1/random.php'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['meals'] != null) {
        return Meal.fromJson(data['meals'][0]);
      }
    }
    return null;
  }

}
