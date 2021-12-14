import 'package:flutter/material.dart';
import 'package:users/apps/albums/models.dart';
import 'package:users/widgets.dart';

class AlbumsDetails extends StatefulWidget {
  AlbumsDetails({Key? key, required this.id}) : super(key: key);
  String id;
  @override
  _AlbumsDetailsState createState() => _AlbumsDetailsState();
}

class _AlbumsDetailsState extends State<AlbumsDetails> {
  late Future future;
  late Album currentAlbum;
  @override
  void initState() {
    super.initState();
    future = fetchFuture();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        Widget result = loader();
        if (snapshot.hasData) {
          result = fetchBody();
        } else if (snapshot.hasError) {
          result = fetchError(snapshot.error.toString());
        }
        return result;
      },
    );
  }

  Future<bool> fetchFuture() async {
    currentAlbum = await Album.fetchAlbumById(int.parse(widget.id));

    return true;
  }

  Widget fetchBody() {
    return Scaffold(
      appBar: AppBar(
        title: Text(currentAlbum.title),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: List.generate(currentAlbum.photos.length,
              (index) => itemWidget(currentAlbum.photos[index])),
        ),
      ),
    );
  }

  Widget itemWidget(Photo photo) {
    return ListTile(
      title: Text(photo.title),
      leading: Image.network(photo.thumbnailUrl),
    );
  }
}
