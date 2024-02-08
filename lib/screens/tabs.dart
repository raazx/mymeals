import 'package:flutter/material.dart';
import 'package:mymeals/data/dummy_data.dart';
import 'package:mymeals/models/meal.dart';
import 'package:mymeals/screens/categories.dart';
import 'package:mymeals/screens/meals_screen.dart';
import 'package:mymeals/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  var activePageTitle = 'Categoriets';
  List<Meal> _favorietmeals = [];

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _toggleMealFavorietStatus(Meal meal) {
    final isExisting = _favorietmeals.contains(meal);
    if (isExisting) {
      _favorietmeals.remove(meal);
      _showInfoMessage('Meal is no longer a favorite.');
    } else {
      _favorietmeals.add(meal);
      _showInfoMessage('Marked as a favorite!');
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
      activePageTitle = 'YourFavoriets';
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'Filters') {}
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(
      availableMeals: dummyMeals,
      onToggleFavorite: _toggleMealFavorietStatus,
    );

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        title: 'Favoriets',
        meals: _favorietmeals,
        onToggleFavorite: _toggleMealFavorietStatus,
      );
    }

    return Scaffold(
      drawer: MainDrawer(onSelectScreen: _setScreen),
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          const BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorite'),
        ],
        onTap: _selectPage,
      ),
      body: activePage,
    );
  }
}
