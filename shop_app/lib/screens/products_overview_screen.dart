import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';

import '../providers/cart.dart';
import '../screens/cart_screen.dart';

import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../widgets/app_drawer.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    // Provider.of<Products>(context).fetchAndSetProducts();
    // this wont work like this but if the listener is set to false then it will work here too.
    // why so, these .of(context) things dont work since the widget is not fully wired up,
    // basically initState() loads even before context.

    // TWO WORK AROUNDS..
    // Future.delayed(Duration.zero).then(
    //   (_) => Provider.of<Products>(context).fetchAndSetProducts(),
    // );
    // However, this is not the same as writing like above case, although this is Duration.zero
    // still flutter considers it as a TODO task, tfore, best approach is didChangeDependencies()
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // do not use async await here, since it will change what the method returns.
    // as this method doesnt return a future and is an internal method, interal method's
    // return type is not recommended to be changed.
    // TODO: implement didChangeDependencies
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    //final productsContainer = Provider.of<Products>(context);
    var scaffold = Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Products'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              // if (selectedValue == FilterOptions.Favorites)
              //   productsContainer.showFavorites();
              // else
              //   productsContainer.showAll();
              setState(() {
                if (selectedValue == FilterOptions.Favorites)
                  _showOnlyFavorites = true;
                else
                  _showOnlyFavorites = false;
              });
            },
            child: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Your Favorites'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (context, cart, ch) {
              return Badge(
                child: ch, //mapped here
                value: cart.itemCount.toString(),
              );
            },
            child: IconButton(
              // this child will not rebuild as it is mapped to the consumer property 'child'
              icon: Icon(Icons.shopping_cart),
              onPressed: () =>
                  Navigator.of(context).pushNamed(CartScreen.routeName),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(
              _showOnlyFavorites,
            ), // Passing here to get the, filtering logic done as this widget builds the grid view.
    );
    return scaffold;
  }
}
