import 'package:flutter/cupertino.dart';

class GroupBlog {
  final String id;
  final double title;

  final DateTime dateTime;

  GroupBlog({
    required this.id,
    required this.title,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<GroupBlog> _blogCluster = [];

  List<GroupBlog> get orders {
    return [..._blogCluster];
  }
}
