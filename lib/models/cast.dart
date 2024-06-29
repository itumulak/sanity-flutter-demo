import 'package:flutter/foundation.dart';

class Cast {
  final String id;
  final String name;
  // final Uri imgUrl;
  // final int imgWidth;
  // final int imgHeight;

  Cast({
    required this.id,
    required this.name,
    // required this.imgUrl,
    // required this.imgWidth,
    // required this.imgHeight,
  });

  factory Cast.fromJson(Map<String, dynamic> json) {
    // todo figure and fix why image URL, image width, and image height will not display

    return Cast(
      id: json['person']['_id'],
      name: json['person']['name'],
      // imgUrl: json['person']['image']['asset']['url'],
      // imgWidth: json['person']['image']['asset']['metadata']['dimensions']['width'],
      // imgHeight: json['person']['image']['asset']['metadata']['dimensions']['height'],
    );
  }
}
