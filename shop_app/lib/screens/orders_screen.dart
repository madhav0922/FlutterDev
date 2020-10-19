import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    _isLoading = true;
    Provider.of<Orders>(context, listen: false).fetchandSetOrders().then(
          (_) => setState(() {
            _isLoading = false;
          }),
        );
    //  this will work since listen is set to false
    super.initState();
  }

  // ALL THIS NOT NEEDED IF YOU HAVE TO SET THE LISTENER TO FALSE.
  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   if (_isInit) {
  //     setState(() {
  //       _isLoading = true;
  //     });

  //     Provider.of<Orders>(context, listen: false).fetchandSetOrders().then((_) {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     });
  //   }
  //   _isInit = false;
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: orderData.orders.length,
              itemBuilder: (ctx, index) => OrderItem(
                orderData.orders[index],
              ),
            ),
    );
  }
}
