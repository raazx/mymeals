import 'package:flutter/material.dart';
import 'package:mymeals/models/meal.dart';
import 'package:mymeals/screens/meal_details.dart';
import 'package:mymeals/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
  });

  final String? title;
  final List<Meal> meals;

  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(
          meal: meal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Scaffold(
      appBar: AppBar(title: Text(title!)),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Uh oh ... nothing here!',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              'Try selecting a different category!',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          ],
        ),
      ),
    );

    if (meals.isNotEmpty) {
      content = Scaffold(
        appBar: AppBar(title: Text(title!)),
        body: ListView.builder(
          itemCount: meals.length,
          itemBuilder: (ctx, index) => Hero(
            tag: meals[index].id,
            child: MealItem(
              meal: meals[index],
              onSelectMeal: (meal) {
                selectMeal(context, meal);
              },
            ),
          ),
        ),
      );
    }

    if (title == null) {
      return content;
    }

    return content;
  }
}
