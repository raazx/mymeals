import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mymeals/data/dummy_data.dart';
import 'package:mymeals/provider/favoriets_provider.dart';
import 'package:mymeals/provider/filters_provider.dart';
import 'package:mymeals/screens/categories.dart';
import 'package:mymeals/screens/filters.dart';
import 'package:mymeals/screens/meals_screen.dart';
import 'package:mymeals/widgets/main_drawer.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  var activePageTitle = 'Categoriets';

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      await Navigator.of(context).push<Map<Filters, bool>>(MaterialPageRoute(
        builder: (context) => const FiltersScreen(),
      ));
    } else {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            const CategoriesScreen(availableMeals: dummyMeals),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final avilableMeals = ref.watch(filtersMealProviders);

    Widget activePage = CategoriesScreen(
      availableMeals: avilableMeals,
    );

    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoritemealsProvider);
      activePage = MealsScreen(
        title: 'Favoriets',
        meals: favoriteMeals,
      );
    }

    return Scaffold(
      drawer: MainDrawer(onSelectScreen: _setScreen),
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorite'),
        ],
        onTap: _selectPage,
      ),
      body: activePage,
    );
  }
}
