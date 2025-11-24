import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../widgets/category_grid.dart';
import '../services/api_service.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ApiService _apiService = ApiService();
  final TextEditingController _searchController = TextEditingController();

  List<FoodCategory> _category = [];
  List<FoodCategory> _filteredCategory = [];

  bool _isLoading = true;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadCategoryList();
  }

  Future<void> _loadCategoryList() async {
    final categoryList = await _apiService.loadCategories();

    setState(() {
      _category = categoryList;
      _filteredCategory = categoryList;
      _isLoading = false;
    });
  }

  void _filterCategory(String query) {
    setState(() {
      _searchQuery = query;

      if (query.isEmpty) {
        _filteredCategory = _category;
      } else {
        _filteredCategory = _category
            .where((c) =>
            c.strCategory.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.shuffle),
            tooltip: "Random Recipe",
            onPressed: () {
              Navigator.pushNamed(
                context,
                "/mealDetails",
                arguments: {"isRandom": true},
              );
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search category by name...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: _filterCategory,
            ),
          ),
          Expanded(
            child: _filteredCategory.isEmpty && _searchQuery.isNotEmpty
                ? const Center(
              child: Text(
                "No categories found!",
                style: TextStyle(fontSize: 16),
              ),
            )
                : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: CategoryGrid(category: _filteredCategory),
            ),
          ),
        ],
      ),
    );
  }
}
