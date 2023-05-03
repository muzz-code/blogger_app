import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'blog.dart';


class Blogs with ChangeNotifier {
  List<Blog> _items = [
    Blog(
      id: 'p1',
      name: 'Hope',
      description: 'Politics is a very important topic that affects us all',
      title: 'Politics',
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Blog(
      id: 'p2',
      name: 'Eddy',
      description: 'Geography is older than even the existence of man',
      title: 'Geography',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Blog(
      id: 'p3',
      name: 'Osasu',
      description: 'Medicine is the single most important subject.',
      title: 'Geography',
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Blog(
      id: 'p4',
      name: 'Onome',
      description: 'Prepare any meal you want.',
      title: 'Food',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  List<Blog> get items {
    return [..._items];
  }

  List<Blog> get favoriteItems {
    return _items.where((blogItem) => blogItem.isFavourite).toList();
  }

  Blog findById(String id) {
    return _items.firstWhere((blog) => blog.id == id);
  }

  void addBlog(Blog blog) {
    final newBlog = Blog(
        name: blog.name,
        imageUrl: blog.imageUrl,
        id: DateTime.now().toString(),
        description: blog.description,
        title: blog.title);
    _items.add(newBlog);
    notifyListeners();
  }

  void updateBlog(String id, Blog newBlog) {
    final blogIndex = _items.indexWhere((prod) => prod.id == id);
    if (blogIndex >= 0) {
      _items[blogIndex] = newBlog;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void deleteBlog(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
