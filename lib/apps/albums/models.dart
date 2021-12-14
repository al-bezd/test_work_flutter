import 'package:users/apps/users/models.dart';
import 'package:users/apps/albums/urls.dart' as urls;

class Album extends Base {
  Album.init(val) : super.init(val) {
    userId = val['userId'];
    id = val['id'];
    title = val['title'];
    if (val['photos'] != null) {
      photos = List.generate(
          val['photos'].length, (index) => Photo.init(val['photos']));
    }
  }

  static Future<Album> fetchAlbumById(int id) async {
    var tmp = await urls.fetchAlbumById(id);
    var tmpComments = await urls.fetchPhotoByAlbumId(id);
    Album album = Album.init(tmp);
    album.photos = List.generate(
        tmpComments.length, (index) => Photo.init(tmpComments[index]));
    return album;
  }

  late int userId;
  late int id;
  late String title;
  List<Photo> photos = [];
}

/*  "albumId": 1,
    "id": 1,
    "title": "accusamus beatae ad facilis cum similique qui sunt",
    "url": "https://via.placeholder.com/600/92c952",
    "thumbnailUrl": "https://via.placeholder.com/150/92c952" */

class Photo extends Base {
  Photo.init(val) : super.init(val) {
    albumId = val['albumId'];
    id = val['id'];
    title = val['title'];
    url = val['url'];
    thumbnailUrl = val['thumbnailUrl'];
  }

  late int albumId;
  late int id;
  late String title;
  late String url;
  late String thumbnailUrl;
}
