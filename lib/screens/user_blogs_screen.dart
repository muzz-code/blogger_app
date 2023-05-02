import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/blog.dart';
import '../provider/blog_provider.dart';
import '../widgets/user_blog_item.dart';
import './add_edit_blog_screen.dart';

class UserBlogsScreen extends StatefulWidget {
  static const routeName = '/user-blogs';

  @override
  _UserBlogsScreenState createState() => _UserBlogsScreenState();
}

class _UserBlogsScreenState extends State<UserBlogsScreen> {
  String _searchQuery = '';
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Blogs>(context);
    final filteredProducts = productsData.items.where((product) =>
        product.name.toLowerCase().contains(_searchQuery.toLowerCase()));

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
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  labelText: 'search',
                  suffixIcon: Icon(Icons.search),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredProducts.length,
                itemBuilder: (_, i) => Column(
                  children: [
                    UserBlogItem(
                      filteredProducts.toList()[i].id,
                      filteredProducts.toList()[i].name,
                      filteredProducts.toList()[i].imageUrl,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

