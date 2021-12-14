import 'package:flutter/material.dart';
import 'package:users/main.dart';
import 'package:users/widgets.dart';

class UsersList extends StatefulWidget {
  const UsersList({Key? key}) : super(key: key);

  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  late Future future;

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
    await globalObject.setUsers();
    return true;
  }

  Widget fetchBody() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Пользователи'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: List.generate(
              globalObject.users.length, (index) => fetchListItem(index)),
        ),
      ),
    );
  }

  Widget fetchListItem(int index) {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, '/user/${globalObject.users[index].id}');
      },
      leading: Container(
        width: 40,
        height: 40,
        alignment: AlignmentDirectional.center,
        decoration:
            const BoxDecoration(color: Colors.amber, shape: BoxShape.circle),
        child: Text('${index + 1}'),
      ),
      title: Text(globalObject.users[index].username),
      subtitle: Text(globalObject.users[index].name),
    );
  }
}
