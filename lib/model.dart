import 'package:users/apps/users/models.dart';
import 'package:users/apps/users/urls.dart';

class Singleton {
  List<User> users = [];
  User? currentUser;

  Future<void> setUsers() async {
    var val = await fetchUsers();
    users = [];
    for (var i in val) {
      users.add(User.init(i));
    }
  }
}
