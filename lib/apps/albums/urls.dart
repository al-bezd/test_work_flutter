import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

Future fetchPhotoByAlbumId(int id) async {
  String url = 'https://jsonplaceholder.typicode.com/albums/$id/photos';
  print(url);
  Response response = await http.get(Uri.parse(url));
  return jsonDecode(response.body);
}

Future fetchAlbumById(int id) async {
  String url = 'https://jsonplaceholder.typicode.com/albums/$id';
  print(url);
  Response response = await http.get(Uri.parse(url));
  return jsonDecode(response.body);
}
