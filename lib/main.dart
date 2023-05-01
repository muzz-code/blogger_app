import 'package:blogger_app/screens/add_edit_blog_screen.dart';
import 'package:blogger_app/screens/blog_details.dart';
import 'package:blogger_app/screens/user_blogs_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './provider/groups.dart';
import 'provider/blog_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Blogs(),
        ),
        // ChangeNotifierProvider.value(
        //   value: Cart(),
        // ),
        ChangeNotifierProvider.value(
          value: Orders(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.purple, accentColor: Colors.deepOrange),
        home: UserBlogsScreen(),
        routes: {
          BlogDetailScreen.routeName: (ctx) => BlogDetailScreen(),
          UserBlogsScreen.routeName: (ctx) => UserBlogsScreen(),
          EditBlogScreen.routeName: (ctx) => EditBlogScreen(),
        },
      ),
    );
  }
}
