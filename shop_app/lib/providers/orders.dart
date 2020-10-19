import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../providers/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchandSetOrders() async {
    const url = 'https://bankinterestrates-fa81e.firebaseio.com/orders.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      // dont write map here in place of dynamic as flutter wont take it. xD
      print(extractedData);
      if (extractedData == null) return;
      // dont execute further if there are no orders to avoid errors.
      final List<OrderItem> loadedOrders = [];
      extractedData.forEach((orderId, orderData) {
        // for each to iterate through each key that firebase provides in its map (response).
        loadedOrders.add(OrderItem(
          // .add adds the item at end of list.
          id: orderId,
          amount: orderData['amount'],
          dateTime: DateTime.parse(orderData['dateTime']),
          products: (orderData['products'] as List<dynamic>)
              .map((item) => CartItem(
                    id: item['id'],
                    title: item['title'],
                    quantity: item['quantity'],
                    price: item['price'],
                  ))
              .toList(),
        ));
        _orders = loadedOrders.reversed.toList();
        // in order to load recent orders first rather than oldest.
        notifyListeners();
      });
    } catch (error) {
      throw error;
    }
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    const url = 'https://bankinterestrates-fa81e.firebaseio.com/orders.json';
    final timeStamp = DateTime.now();
    // otherwise datetime will become different online and offline
    final response = await http.post(
      url,
      body: json.encode({
        'amount': total,
        'dateTime': timeStamp.toIso8601String(),
        'products': cartProducts
            .map((cp) => {
                  'id': cp.id,
                  'title': cp.title,
                  'quantity': cp.quantity,
                  'price': cp.price,
                })
            .toList(), // mapped to a list of maps, for firebase.
      }),
    );
    _orders.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['name'],
        amount: total,
        products: cartProducts,
        dateTime: timeStamp,
      ),
    );
    notifyListeners();
  }
}
