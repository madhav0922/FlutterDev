import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart';
import '../providers/cart.dart' show Cart;
// This will only import Cart and not CartItem from this import. As we can also see below,  we are only interested in (or using) the Cart class.

// import '../widgets/cart_item.dart' as ci;
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  final _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Total', style: TextStyle(fontSize: 20)),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color:
                            Theme.of(context).primaryTextTheme.headline6.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  OrderButton(cart: cart),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          // Use expanded to eliminate the error: Vertical viewport was given unbounded height.
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, i) {
                // return ci.CartItem(); // either add as ci on the import and use ci.CartItem
                return CartItem(
                  cart.items.values.toList()[i].id,
                  cart.items.keys.toList()[i],
                  cart.items.values.toList()[i].title,
                  cart.items.values.toList()[i].price,
                  cart.items.values.toList()[i].quantity,
                  // .values.toList() used so that we are working with lists and not maps(gave error hence the conversion).
                );
              },
              itemCount: cart.items.length,
            ),
          ),
        ],
      ),
    );
  }
}

//created or extracted this widget to avoid rebuilding the whole upper class,
// by making it stateful, instead make this class stateful.
class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: _isLoading
          ? CircularProgressIndicator()
          : Text(
              'ORDER NOW!',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
      onPressed: (widget.cart.totalAmount <= 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true; // to show loading spinner
              });
              await Provider.of<Orders>(context, listen: false).addOrder(
                // since we are not interested in changes in orders.
                widget.cart.items.values.toList(),
                widget.cart.totalAmount,
              );
              setState(() {
                _isLoading = false;
              });
              widget.cart.clear();
            },
    );
  }
}
