import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-details';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    // final loadedProduct = Provider.of<Products>(context).items.firstWhere((prod) => prod.id == productId);
    // TO make this leaner we move the logic of firstWhere to the products class itself.
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(productId);
    // listen: false used here configures that once the screen is loaded i.e.
    // the details will not change as it is not listening.. even if the products
    // list change, and you dont want to do that because..like an example.. that product
    // details will keep on refreshing if new products keep on adding. but however,
    // i also wonder that if price refreshes then what will happen..because that should be loaded.

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(loadedProduct.title),
      // ),
      body: // if many things are scrolling on the same page individually then use CustomScrollView.
          CustomScrollView(
        slivers: // means scrollable things/widgets
            [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(loadedProduct.title),
              background: Hero(
                tag: loadedProduct.id,
                // Also need to implement hero widget
                // to the screen where it will lead.
                child: Image.network(
                  loadedProduct.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: 10,
                ),
                Text(
                  '\$${loadedProduct.price}',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  child: Text(
                    '${loadedProduct.description}',
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                ),
                SizedBox(
                  height: 800,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
