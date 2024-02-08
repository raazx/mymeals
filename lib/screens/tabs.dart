import 'package:flutter/material.dart';
import 'package:mymeals/data/dummy_data.dart';
import 'package:mymeals/models/meal.dart';
import 'package:mymeals/screens/categories.dart';
import 'package:mymeals/screens/filters.dart';
import 'package:mymeals/screens/meals_screen.dart';
import 'package:mymeals/widgets/main_drawer.dart';

const kInintialFilters = {
  Filters.glutenFree: false,
  Filters.lactoseFree: false,
  Filters.vegetarianFree: false,
  Filters.veganFree: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  var activePageTitle = 'Categoriets';
  List<Meal> _favorietmeals = [];
  Map<Filters, bool> _selectedFilters = kInintialFilters;

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
    if (identifier == 'filters') {
      final resualt = await Navigator.of(context)
          .push<Map<Filters, bool>>(MaterialPageRoute(
        builder: (context) => FiltersScreen(
          currentFilters: _selectedFilters,
        ),
      ));
      setState(() {
        _selectedFilters = resualt ?? kInintialFilters;
      });
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final avilableMeals = dummyMeals.where((element) {
      if (_selectedFilters[Filters.lactoseFree]! && !element.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filters.glutenFree]! && !element.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filters.vegetarianFree]! && !element.isVegetarian) {
        return false;
      }
      if (_selectedFilters[Filters.veganFree]! && !element.isVegan) {
        return false;
      }
      return true;
    }).toList();
    Widget activePage = CategoriesScreen(
      availableMeals: avilableMeals,
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
