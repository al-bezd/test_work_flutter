import 'package:users/apps/users/models.dart';
import 'package:users/apps/posts/urls.dart' as urls;

class Post extends Base {
  Post.init(val) : super.init(val) {
    userId = val['userId'];
    id = val['id'];
    title = val['title'];
    body = val['body'];
  }

  static Future<Post> fetchPostById(String id) async {
    var tmp = await urls.fetchPostById(id);
    var tmpComments = await urls.fetchCommentsByPostId(id);
    Post post = Post.init(tmp);
    post.comments = List.generate(
        tmpComments.length, (index) => Comment.init(tmpComments[index]));
    return post;
  }

  late int userId;
  late int id;
  late String title;
  late String body;
  List<Comment> comments = [];
}

class Comment extends Base {
  Comment.init(val) : super.init(val) {
    postId = val['postId'];
    id = val['id'];
    name = val['name'];
    email = val['email'];
    body = val['body'];
  }

  static Future<Comment?> sendComment(
      {int? postId, String? name, String? email, String? text}) async {
    var tmp = await urls.sendComment(postId!, name!, email!, text!);
    if (tmp != null) {
      return Comment.init(tmp);
    }
    return null;
  }

  late int postId;
  late int id;
  late String name;
  late String email;
  late String body;
}
