class Meal {

  final String idMeal;
  final String strMeal;
  final String strMealThumb;
  final String? strInstructions;
  final String? strYoutube;
  final List<String>? ingredients;

  Meal({
    required this.idMeal,
    required this.strMeal,
    required this.strMealThumb,
    this.strInstructions,
    this.strYoutube,
    this.ingredients,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    List<String> ing = [];
    for (int i = 1; i <= 20; i++) {
      final ingredient = json['strIngredient$i'];
      if (ingredient != null && ingredient.toString().isNotEmpty) {
        ing.add(ingredient);
      }
    }

    return Meal(
      idMeal: json['idMeal'],
      strMeal: json['strMeal'],
      strMealThumb: json['strMealThumb'],
      strInstructions: json['strInstructions'],
      strYoutube: json['strYoutube'],
      ingredients: ing,
    );
  }

}