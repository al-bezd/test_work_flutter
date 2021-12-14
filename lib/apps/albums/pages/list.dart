import 'package:flutter/material.dart';
import 'package:users/main.dart';

class AlbumsList extends StatefulWidget {
  AlbumsList({Key? key}) : super(key: key);

  @override
  _AlbumsListState createState() => _AlbumsListState();
}

class _AlbumsListState extends State<AlbumsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Все альбомы'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: List.generate(
              globalObject.currentUser!.albums.length,
              (index) => ListTile(
                    onTap: () {
                      Navigator.pushNamed(context,
                          '/albums/${globalObject.currentUser!.albums[index].id}');
                    },
                    title: Text(globalObject.currentUser!.albums[index].title),
                  )),
        ),
      ),
    );
  }
}
