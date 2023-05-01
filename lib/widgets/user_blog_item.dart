import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/blog_provider.dart';
import '../screens/add_edit_blog_screen.dart';
import '../screens/blog_details.dart';

class UserBlogItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserBlogItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(BlogDetailScreen.routeName, arguments: id);
      },
      child: Card(
        child: ListTile(
          title: Text(title),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
          ),
          trailing: Container(
            width: 100,
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(EditBlogScreen.routeName, arguments: id);
                  },
                  color: Theme.of(context).primaryColor,
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    Provider.of<Blogs>(context, listen: false)
                        .deleteBlog(id);
                  },
                  color: Theme.of(context).errorColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
