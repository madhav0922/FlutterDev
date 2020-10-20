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
  // var _isLoading = false;

  // needed in SPECIAL CASE of future builder.
  Future _ordersFuture;
  Future _obtainOrdersFuture() {
    return Provider.of<Orders>(context, listen: false).fetchandSetOrders();
  }

  @override
  void initState() {
    // TODO: implement initState
    _ordersFuture = _obtainOrdersFuture();
    super.initState();
  }

  // not needed with future builder.
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   _isLoading = true;
  //   Provider.of<Orders>(context, listen: false).fetchandSetOrders().then(
  //         (_) => setState(() {
  //           _isLoading = false;
  //         }),
  //       );
  //   //  this will work since listen is set to false
  //   super.initState();
  // }

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
    // final orderData = Provider.of<Orders>(context);
    // When using Future builder then dont setup a listener here, use consumer instead.
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: RefreshIndicator(
        onRefresh: _obtainOrdersFuture,
        child: FutureBuilder(
            future: _ordersFuture,
            builder: (ctx, dataSnapshot) {
              if (dataSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (dataSnapshot.error != null) {
                // do error handling stuff..
                return Center(
                  child: Text('An error occurred!'),
                );
              } else {
                return Consumer<Orders>(
                  builder: (ctx, orderData, child) => ListView.builder(
                    itemCount: orderData.orders.length,
                    itemBuilder: (ctx, index) => OrderItem(
                      orderData.orders[index],
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }
}
