import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/blog_provider.dart';
import '../widgets/user_blog_item.dart';
import './add_edit_blog_screen.dart';

class UserBlogsScreen extends StatelessWidget {
  static const routeName = '/user-blogs';

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Blogs>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blogs'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditBlogScreen.routeName);
            },
          ),
        ],
      ),
      // drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productsData.items.length,
          itemBuilder: (_, i) => Column(
            children: [
              UserBlogItem(
                productsData.items[i].id,
                productsData.items[i].name,
                productsData.items[i].imageUrl,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
