import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String token, String userId) async {
    // OPTIMISTIC UPDATING
    final oldStatus = isFavorite; // BACKUP
    isFavorite = !isFavorite;
    notifyListeners(); // kind of like setState
    final url =
        'https://bankinterestrates-fa81e.firebaseio.com/userFavorites/$userId/$id.json?auth=$token';
    // TRY TO SEND PATCH
    try {
      // THIS WONT WORK THOUGH if an error occurs, since,
      // for patch,put and delete, http package dont send error.
      // final response = await http.patch(url,
      //     body: json.encode({
      //       'isFavorite': isFavorite,
      //     })); // THIS CHANGED since now we are managing favorite status accn to user, using http.put().
      // What is the diff? the diff is that all the products marked by a user are now under a single
      // entry of respective userId, rather than redundant userIds.
      // WE HAVE KEPT THIS TRY CATCH LOGIC HERE ANYWAY, since,
      // any network error may occur.
      final response = await http.put(url,
          body: json.encode(isFavorite)); //  CHANGED TO this
      if (response.statusCode >= 400) {
        // isFavorite = oldStatus;
        // notifyListeners();
        // Code duplication tha so switched to function.
        _setFavValue(oldStatus);
      }
    } catch (error) {
      // IF ANY ERROR RESTORE STATUS
      // isFavorite = oldStatus;
      // notifyListeners();
      // Code duplication tha so switched to function.
      _setFavValue(oldStatus);
    }
  }
}
