import 'package:flutter/material.dart';

import '../screens/category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  CategoryItem(this.id, this.title, this.color);

  // ONE WAY TO NAVIGATE THROUGH DIFF SCREENS

  // void selectCategory(BuildContext ctx) {
  //   Navigator.of(ctx).push(
  //     MaterialPageRoute(
  //         // there also exists a cupertino page route or material page route
  //         builder: (_) {
  //       return CategoryMealsScreen(
  //         id,
  //         title,
  //       );
  //     }),
  //   );
  // }

  // ANOTHER AND BETTER WAY THORUGH ROUTES

  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      CategoryMealsScreen.routeName,
      arguments: {
        'id': id,
        'title': title,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // Just like gesture detector to get onTap. Also gives option to add ripple effect on tap
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.all(15),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.7),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
          //cant use const for optimization here because hover over BorderRadius and check the class method it does not have a const method for BorderRadius.circular() but has it for BorderRadius.all()
        ),
      ),
    );
  }
}
