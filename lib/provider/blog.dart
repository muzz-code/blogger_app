import 'package:flutter/material.dart';

class Blog with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final String title;
  final String imageUrl;
  bool isFavourite;

  Blog(
      {required this.name,
      required this.imageUrl,
      required this.id,
      required this.description,
      this.isFavourite = false,
      required this.title});

  void toggleFavoriteStatus() {
    isFavourite = !isFavourite;
    notifyListeners();
  }
}
