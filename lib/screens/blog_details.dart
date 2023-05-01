import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/blog.dart';
import '../provider/blog_provider.dart';

class BlogDetailScreen extends StatelessWidget {
  // final String title;
  // final double price;

  // ProductDetailScreen(this.title, this.price);
  static const routeName = '/blog-detail';

  @override
  Widget build(BuildContext context) {
    final blogId =
        ModalRoute.of(context)?.settings.arguments as String; // is the id!
    final loadedBlog = Provider.of<Blogs>(
      context,
      listen: false,
    ).findById(blogId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedBlog.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                loadedBlog.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '\$${loadedBlog.title}',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                loadedBlog.description,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
