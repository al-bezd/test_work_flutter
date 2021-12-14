import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

Future<List> fetchUsers() async {
  String url = 'https://jsonplaceholder.typicode.com/users';
  print(url);
  Response response = await http.get(Uri.parse(url));
  return jsonDecode(response.body);
}

Future<List> fetchPostsById(int id) async {
  String url = 'https://jsonplaceholder.typicode.com/posts?userId=$id';
  print(url);
  Response response = await http.get(Uri.parse(url));
  return jsonDecode(response.body);
}

Future<List> fetchAlbumsById(int id) async {
  String url = 'https://jsonplaceholder.typicode.com/albums?userId=$id';
  print(url);
  Response response = await http.get(Uri.parse(url));
  return jsonDecode(response.body);
}
