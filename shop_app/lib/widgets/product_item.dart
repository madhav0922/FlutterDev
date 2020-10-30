import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/product_detail_screen.dart';
import '../providers/product.dart';
import '../providers/cart.dart';
import '../providers/auth.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    // NEXT LEVEL OPTIMIZATION
    // getting listen to be false here makes the who build function NOT REFRESH everytime and
    // build the hold widget tree again... see ALTERNATIVE SYNTAX 1 BELOW
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context);
    final authData = Provider.of<Auth>(context);
    // print('build fn rebuilds');
    // you will see that this will print, only first time or when build actually rebuilds but not when favorite is clicked.
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GridTile(
        //image
        child: GestureDetector(
          onTap: () {
            return Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Hero(
            tag: product.id,
            // Hero widget takes a unique tag, in order to identify image or whatever you want to animate.
            // tag can take any tag you want it to have, just a unique identifier is preffered ofc.
            child: FadeInImage(
              placeholder: AssetImage('assets/images/product-placeholder.png'),
              image: NetworkImage(
                product.imageUrl,
              ),
              fit: BoxFit.cover,
              // Earlier this was used.
              // Image.network(
              //   product.imageUrl,
            ),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: Consumer<Product>(
            // Since, not needed here the 3rd argument "child" is replaced with "_" here.
            builder: (ctx, product, _) {
              // ALTERNATIVE SYNTAX 1
              // product here is the variable like there was above to get the context.
              // Advantage 1: Only this will rebuild with the favorite being marked or unmarked.
              // Advantage 2: If suppose we have parts in the following widget that should not update, then
              // using child is what comes to play, we can use the child property to map something that shouldn't
              // change or update in the widget. See following comments.
              return IconButton(
                icon: (product.isFavorite)
                    ? Icon(Icons.favorite)
                    : Icon(Icons.favorite_border),
                color: Theme.of(context).accentColor,
                // label: child, // suppose there is a label then child can be referred to that label and will not change.
                // the child written below will be referenced here.
                onPressed: () => product.toggleFavoriteStatus(
                    authData.token, authData.userId),
                // token retrieved using provider.
              );
            },
            // child: Text('Never changes!'), // This will be referenced to the child item above and will not be rebuilt since it is outside of the builder function.
          ),
          title: Text(product.title),
          trailing: IconButton(
              icon: Icon(Icons.shopping_cart),
              color: Theme.of(context).accentColor,
              onPressed: () {
                cart.addItems(product.id, product.title, product.price);
                Scaffold.of(context).hideCurrentSnackBar();
                //hides currently shown snackbar, basically overrides.
                Scaffold.of(context).showSnackBar(
                  // This scaffold reference is to the nearest scaffold that is controlling the screen, as this dart file doesnt have a scaffold, nearest would be the scaffold from where it is called, i.e. product_overview_screen <- products_grid <- product_item
                  SnackBar(
                    content: Text('Item added to Cart!'),
                    action: SnackBarAction(
                      label: 'UNDO',
                      onPressed: () => cart.deleteSingleItem(product.id),
                    ),
                  ),
                );
              }),
        ),
        // header rect containing favorite, title, cart
      ),
    );
  }
}
