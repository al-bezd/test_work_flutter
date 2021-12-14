import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

Future fetchPostById(String id) async {
  String url = 'https://jsonplaceholder.typicode.com/posts/$id';
  print(url);
  Response response = await http.get(Uri.parse(url));
  return jsonDecode(response.body);
}

Future fetchCommentsByPostId(String id) async {
  String url = 'https://jsonplaceholder.typicode.com/posts/$id/comments';
  print(url);
  Response response = await http.get(Uri.parse(url));
  return jsonDecode(response.body);
}

Future sendComment(int postId, String name, String email, String text) async {
  String url = 'https://jsonplaceholder.typicode.com/comments/';
  print(url);
  Response response = await http.post(Uri.parse(url),
      body: jsonEncode(
          {"postId": postId, "name": name, "email": email, 'body': text}),
      headers: {
        'Content-type': 'application/json; charset=UTF-8',
      });
  return jsonDecode(response.body);
}
