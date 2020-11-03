import 'dart:io';

import 'package:flutter/foundation.dart';

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  const PlaceLocation({
    @required this.latitude,
    @required this.longitude,
    this.address,
  });
}

class Place {
  final String id;
  final String title;
  final PlaceLocation location;
  // As we learnt any class we define also automatically creates a type we can use.
  final File image;
  // import dart:io
  // used file since, images are stored as a file on the device.

  Place({
    @required this.id,
    @required this.title,
    @required this.location,
    @required this.image,
  });
}
