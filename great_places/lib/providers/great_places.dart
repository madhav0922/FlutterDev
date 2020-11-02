import 'dart:io';

import 'package:flutter/foundation.dart';

import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }
  // Why a copy is returned?
  // so that we can always get access to the items from anywhere in the app but
  // we get access to a copy of items, so if we change that list from the place
  // where we're getting access to it, then we won't change the list here, in this class
  // which is certainly something we want to avoid, so we want to make sure that this
  // can't be changed from outside because if you would change it from outside, you
  // wouldn't trigger notifyListeners() and therefore you would change the data
  // without updating the app, which would be bad.

  void addPlace(String pickedTitle, File pickedImage) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: pickedTitle,
      image: pickedImage,
      location: null,
    );
    _items.add(newPlace);
    notifyListeners();
  }
}
