import 'package:flutter/material.dart';
import 'package:users/main.dart';

class PostList extends StatefulWidget {
  PostList({Key? key}) : super(key: key);

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Все посты'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: List.generate(
              globalObject.currentUser!.posts.length,
              (index) => ListTile(
                    onTap: () {
                      Navigator.pushNamed(context,
                          '/posts/${globalObject.currentUser!.posts[index].id}');
                    },
                    title: Text(globalObject.currentUser!.posts[index].title),
                  )),
        ),
      ),
    );
  }
}
