import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favouriteMeals;

  FavoritesScreen(this.favouriteMeals);

  @override
  Widget build(BuildContext context) {
    if (favouriteMeals.isEmpty)
      return Center(
        //Scaffold not returned because the tabs will then have a duplicate appBar and this is a screen though but it does not completely control the screen, it is like a fragment.
        child: Text('Favorites'),
      );
    else
      return ListView.builder(
        itemBuilder: (context, index) {
          return MealItem(
            id: favouriteMeals[index].id,
            title: favouriteMeals[index].title,
            imageUrl: favouriteMeals[index].imageUrl,
            duration: favouriteMeals[index].duration,
            complexity: favouriteMeals[index].complexity,
            affordability: favouriteMeals[index].affordability,
            // removeItem: _removeMeal,
          );
        },
        itemCount: favouriteMeals.length,
      );
  }
}
