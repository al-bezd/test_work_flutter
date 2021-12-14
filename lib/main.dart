import 'package:flutter/material.dart';
import 'package:users/apps/albums/pages/details.dart';
import 'package:users/apps/albums/pages/list.dart';
import 'package:users/apps/posts/pages/deatils.dart';
import 'package:users/apps/posts/pages/list.dart';
import 'package:users/apps/users/pages/details.dart';
import 'package:users/apps/users/pages/list.dart';
import 'package:users/model.dart';

import 'functions.dart';

late Singleton globalObject;
void main() {
  globalObject = Singleton();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const UsersList(),
      onGenerateRoute: (settings) {
        List<String> path = settings.name!.split('/');

        Widget? resPage;
        resPage = resPage ?? userRoute(path, resPage);
        resPage = resPage ?? postRoute(path, resPage);
        resPage = resPage ?? albumRoute(path, resPage);

        return MaterialPageRoute(
          builder: (context) => resPage!,
        );
      },
    );
  }

  userRoute(List<String> path, resPage) {
    if (tryOrFalse(() {
      return path[1] == 'user';
    })) {
      if (tryOrFalse(() {
        return path.length == 3;
      })) {
        resPage = resPage ?? UserDetail(id: int.parse(path[2]));
      }
      resPage = resPage ?? const UsersList();
    }
    return resPage;
  }

  postRoute(List<String> path, resPage) {
    if (tryOrFalse(() {
      return path[1] == 'posts';
    })) {
      if (tryOrFalse(() {
        return path.length == 3;
      })) {
        resPage = PostDetails(id: path[2]);
      }
      resPage = resPage ?? PostList();
    }
    return resPage;
  }

  albumRoute(List<String> path, resPage) {
    if (tryOrFalse(() {
      return path[1] == 'albums';
    })) {
      if (tryOrFalse(() {
        return path.length == 3;
      })) {
        resPage = AlbumsDetails(id: path[2]);
      }
      resPage = resPage ?? AlbumsList();
    }
    return resPage;
  }
}
