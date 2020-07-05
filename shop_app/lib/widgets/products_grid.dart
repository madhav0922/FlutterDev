import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './product_item.dart';
import '../providers/products.dart';

class ProductsGrid extends StatelessWidget {
  final showFavs;

  ProductsGrid(this.showFavs);
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    // FILTERING FAVORITES BUT LOGIC IMPLEMENTED AS A GETTER IN CLASS
    final products =
        (showFavs) ? productsData.favoriteItems : productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        // Using a provider on a local level and not in main.
        // change notifier provider automatically cleans the data that is not relevant anymore, like after switching screens etc. This avoids memory leaks.

        // ALTERNATIVE SYNTAX
        // create: (c) => products[i], // rather than using this
        value: products[i],
        // should use .value here with list items or grid. since, context is not required here and doesnt make sense. this may avoid bugs and is efficient.
        child: ProductItem(
            // products[index].id,
            // products[index].title,
            // products[index].imageUrl,
            ),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: products.length,
    );
  }
}
