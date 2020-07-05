import 'package:flutter/foundation.dart';
import 'product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
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

  void addProduct() {
    //add data
    notifyListeners();
  }
}
