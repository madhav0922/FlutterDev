import 'dart:convert';

import 'package:http/http.dart' as http;

const GOOGLE_API_KEY = 'AIzaSyCcJYFJPCJokXUgThmWhYxmjJMgveXblk8';

class LocationHelper {
  static String generateLocationPreviewImage(
      {double latitude, double longitude}) {
    // url taken by searching google maps static api
    // url should always be one liner.
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
    //return 'https://maps.googleapis.com/maps/api/staticmap?center=Brooklyn+Bridge,New+York,NY&zoom=13&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:S%7C40.702147,-74.015794&markers=color:green%7Clabel:G%7C40.711614,-74.012318&markers=color:red%7Clabel:C%7C40.718217,-73.998284&key=$GOOGLE_API_KEY';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY';
    final response = await http.get(url);
    print('reponseeeeeee');
    print(json.decode(response.body));
    // return json.decode(response.body)['results'][0]['formatted_address'];
    // accessing 0th index or first entry because google might find multiple addresses and
    // arrange them according to relevance.
  }
}
