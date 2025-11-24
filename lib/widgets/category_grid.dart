import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../widgets/category_card.dart';

class CategoryGrid extends StatefulWidget {
  final List<FoodCategory> category;

  const CategoryGrid({super.key, required this.category});

  @override
  State<StatefulWidget> createState() => _CategoryGridState();
}

class _CategoryGridState extends State<CategoryGrid> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.category.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return CategoryCard(category: widget.category[index]);
      },
    );
  }
}
