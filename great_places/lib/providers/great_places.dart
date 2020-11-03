import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:great_places/helpers/location_helper.dart';

import '../models/place.dart';
import '../helpers/db_helper.dart';

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

  Place findById(String id) {
    return _items.firstWhere((place) => place.id == id);
  }

  void addPlace(
    String pickedTitle,
    File pickedImage,
    PlaceLocation pickedLocation,
  ) async {
    final address = await LocationHelper.getPlaceAddress(
        pickedLocation.latitude, pickedLocation.longitude);
    final updatedLocation = PlaceLocation(
      latitude: pickedLocation.latitude,
      longitude: pickedLocation.longitude,
      address: address,
    );
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: pickedTitle,
      image: pickedImage,
      location: updatedLocation,
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      // since you cannot store the image file on a db but the path to it.
      'loc_lat': newPlace.location.latitude,
      'loc_lng': newPlace.location.longitude,
      'address': newPlace.location.address,
    });
    // the keys used here should match the fields you set up in the CREATE TABLE query in db helper
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map(
          (item) => Place(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
            location: PlaceLocation(
              latitude: item['loc_lat'],
              longitude: item['loc_lng'],
              address: item['address'],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }
}
