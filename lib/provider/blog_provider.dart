import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'blog.dart';

class Blogs with ChangeNotifier {
  List<Map<String, dynamic>> blogs = [
    {
      "id": "p1",
      "name": "Hope",
      "description": "Politics is a very important topic that affects us all",
      "title": "Politics",
      "imageUrl":
          "https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg",
      "isFavourite": true
    },
    {
      "id": "p2",
      "name": "Eddy",
      "description": "Geography is older than even the existence of man",
      "title": "Geography",
      "imageUrl":
          "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg",
      "isFavourite": true
    },
    {
      "id": "p3",
      "name": "Osasu",
      "description": "Medicine is the single most important subject.",
      "title": "Geography",
      "imageUrl":
          "https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg",
      "isFavourite": true
    },
    {
      "id": "p4",
      "name": "Onome",
      "description": "Prepare any meal you want.",
      "title": "Food",
      "imageUrl":
          "https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg",
      "isFavourite": true
    }
  ];

  List<Map<String, dynamic>> get items {
    return [...blogs];
  }

  List<Map<String, dynamic>> get favoriteItems {
    return blogs.where((blogItem) => blogItem['isFavourite'] as bool).toList();
  }

  Map<String, dynamic> findById(String id) {
    return blogs.firstWhere((blog) => (blog['id'] as String) == id);
  }

  void addBlog(Blog blog) {
    blogs.add({
      "id": blog.id,
      "name": blog.name,
      "description": blog.description,
      "title": blog.title,
      "imageUrl": blog.imageUrl,
      "isFavourite": blog.isFavourite
    });
    notifyListeners();
  }

  void updateBlog(String id, Blog newBlog) {
    final blogIndex = blogs.indexWhere((blog) => (blog['id'] as String) == id);

    if (blogIndex >= 0) {
      Map<String, dynamic> oldBlog = blogs[blogIndex];
      oldBlog['id'] = newBlog.id;
      oldBlog['title'] = newBlog.title;
      oldBlog['name'] = newBlog.name;
      oldBlog['description'] = newBlog.description;
      oldBlog['imageUrl'] = newBlog.imageUrl;
      oldBlog['isFavourite'] = newBlog.isFavourite;

      notifyListeners();
    } else {
      print('...');
    }
  }

  void deleteBlog(String id) {
    blogs.removeWhere((prod) => (prod['id'] as String) == id);
    notifyListeners();
  }
}
