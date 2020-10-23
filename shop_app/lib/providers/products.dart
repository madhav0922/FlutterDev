import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';

import 'product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  var _showFavoritesOnly = false;

  // but what is the issue with managing favorites like this?
  // Even when the user would go to other screen.. the filters would still be applied there as well..because
  // our getter is returning filtered data only.
  // If you want to get application wide filtering then this use case is efficient.
  // but we dont want that here, hence we want to implement FILTERING not using CLASSES, but
  // using WIDGETS(by making a Stateful Widget)

  // List<Product> get items {
  //   if (_showFavoritesOnly)
  //     return _items.where((prodItem) => prodItem.isFavorite).toList();
  //   return [..._items];
  // }

  // void showFavorites() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  final String authToken;
  final String userId;
  Products(this.authToken, this.userId, this._items);

  // LOCAL WIDGET FILTERING LOGIC
  List<Product> get items {
    return [..._items];
  }

  // ALTERNATIVE GETTER TO IMPLEMENT LOGIC BEHIND THE SCENES
  List<Product> get favoriteItems {
    return _items.where((item) => item.isFavorite).toList();
  }

  Product findById(id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    // [bool filterByUser = false] adding [] these, makes it an optional argument.
    final filterPatch =
        filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : null;
    var url =
        'https://bankinterestrates-fa81e.firebaseio.com/products.json?auth=$authToken&$filterPatch';
    // notice the & between two string interpolations, deliberatly kept there.
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      // dont write map here in place of dynamic as flutter wont take it. xD
      if (extractedData == null) return;
      // dont execute further if there are no orders to avoid errors.
      url =
          'https://bankinterestrates-fa81e.firebaseio.com/userFavorites/$userId.json?auth=$authToken';
      final favoriteResponse = await http.get(url);
      final favoriteData = json.decode(favoriteResponse.body);
      // print(json.decode(favoriteResponse.body));
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        // for each to iterate through each key that firebase provides in its map (response).
        loadedProducts.add(Product(
          // .add adds the item at end of list.
          id: prodId,
          title: prodData['title'],
          price: prodData['price'],
          description: prodData['description'],
          imageUrl: prodData['imageUrl'],
          isFavorite: favoriteData == null ? false : favoriteData[prodId],
          // isFavorite: prodData['isFavorite'],
        ));
        _items = loadedProducts;
        notifyListeners();
      });
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProduct(Product product) async {
    //add a product
    final url =
        'https://bankinterestrates-fa81e.firebaseio.com/products.json?auth=$authToken';
    try {
      final response = await http.post(
        // stored into response because it returns a result, i.e a firebase object.
        // returns a future.
        url,
        body: json.encode({
          'title': product.title,
          'price': product.price,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'creatorId': userId, // we have it at the top.
          // 'isFavorite': product.isFavorite, // no longer needed
        }),
      );
      // in async there is no need of .then as the code outside will automatically be treated like .then() future ,as follows..
      //.then((response) {
      final prod = Product(
        //id: DateTime.now().toString(), // since our product does not have a id, in edit_products_screen.
        id: json.decode(response.body)['name'],
        // id retrieved from firebase, good to avoid conflicts between front-end and back-end.
        title: product.title,
        price: product.price,
        description: product.description,
        imageUrl: product.imageUrl,
      );
      _items.add(prod);
      //_items.insert(0, prod); // or to insert at beginning.
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
  //})
  // .catchError((error) {
  //   print(error);
  //   throw error;
  // });

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url =
          'https://bankinterestrates-fa81e.firebaseio.com/products/$id.json?auth=$authToken';
      // targetting a specific product.
      try {
        await http.patch(
          url,
          body: json.encode({
            'title': newProduct.title,
            'price': newProduct.price,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
          }),
        );
        _items[prodIndex] = newProduct;
        notifyListeners();
      } catch (error) {
        throw error;
      }
    }
    // this if check will prevent trying to update products which we don't have.
    else
      print('...');
  }

  Future<void> deleteProduct(String id) async {
    final url =
        'https://bankinterestrates-fa81e.firebaseio.com/products/$id.json?auth=$authToken';
    // optimistic updating rather than deleting
    // how?
    //first copy, for in case any error occurs, we can restore the product.
    // if doesnt then delete.
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];
    // we still have it in memory by doing this and not on server, then remove.
    _items.removeAt(existingProductIndex);
    notifyListeners();
    // since we are now using await, we can remove it before handed.
    // FIRST REMOVE
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      // IF ANY ERROR, THEN RESTORE.
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    } // used custom (our own) exception class here since, http.delete does not throw an error by default.
    existingProduct = null; // OTHERWISE WE FREE THE MEMORY.
  }
}
