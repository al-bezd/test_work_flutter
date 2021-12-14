import 'package:flutter/material.dart';
import 'package:users/apps/users/models.dart';
import 'package:users/main.dart';
import 'package:users/widgets.dart';

class UserDetail extends StatefulWidget {
  UserDetail({Key? key, required this.id}) : super(key: key);
  int id;
  @override
  _UserDetailState createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  late Future future;
  String title = '';
  @override
  void initState() {
    super.initState();
    future = fetchFuture();
  }

  @override
  void dispose() {
    globalObject.currentUser = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder(
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
      ),
    );
  }

  Future<bool> fetchFuture() async {
    globalObject.currentUser =
        globalObject.users.firstWhere((element) => element.id == widget.id);
    title = globalObject.currentUser!.username;
    globalObject.currentUser!.posts = await User.fetchPosts(widget.id);
    globalObject.currentUser!.albums = await User.fetchAlbums(widget.id);

    return true;
  }

  Widget fetchBody() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            titleItem('Пользователь'),
            fetchItem('Имя', globalObject.currentUser!.name),
            fetchItem('Email', globalObject.currentUser!.email),
            fetchItem('Телефон', globalObject.currentUser!.phone),
            fetchItem('Сайт', globalObject.currentUser!.website),
            fetchItemCompany(),
            fetchItemAddress(),
            Stack(
              alignment: AlignmentDirectional.centerEnd,
              children: [
                titleItem('Посты'),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/posts');
                  },
                  child: Text('Все(${globalObject.currentUser!.posts.length})'),
                )
              ],
            ),
            fetchItemList(3, globalObject.currentUser!.posts, '/posts/'),
            Stack(
              alignment: AlignmentDirectional.centerEnd,
              children: [
                titleItem('Альбомы'),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/albums');
                  },
                  child:
                      Text('Все(${globalObject.currentUser!.albums.length})'),
                )
              ],
            ),
            fetchItemList(3, globalObject.currentUser!.albums, '/albums/'),
          ],
        ),
      ),
    );
  }

  Widget titleItem(String text) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );
  }

  Widget fetchItem(String key, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(key), Text(value)],
      ),
    );
  }

  Widget fetchItemCompany() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleItem('Компания'),
        fetchItem('Наименование', globalObject.currentUser!.company!.name),
        fetchItem(
            'catchPhrase', globalObject.currentUser!.company!.catchPhrase),
        fetchItem('bs', globalObject.currentUser!.company!.bs),
      ],
    );
  }

  Widget fetchItemAddress() {
    Address tmp = globalObject.currentUser!.address!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleItem('Адрес'),
        tmp.city == null
            ? const SizedBox()
            : fetchItem('Город', globalObject.currentUser!.address!.city!),
        tmp.street == null
            ? const SizedBox()
            : fetchItem('Улица', globalObject.currentUser!.address!.street!),
        tmp.suite == null
            ? const SizedBox()
            : fetchItem('Suite', globalObject.currentUser!.address!.suite!),
        tmp.zipcode == null
            ? const SizedBox()
            : fetchItem('Zipcode', globalObject.currentUser!.address!.zipcode!),
        tmp.geo == null
            ? const SizedBox()
            : fetchItem('Координаты', '${tmp.geo!.lat}:${tmp.geo!.lng}'),
      ],
    );
  }

  List fetchList(int length, list) {
    if (list.length >= length) {
      List tmp = list.sublist(0, length);
      return tmp;
    }
    return list;
  }

  Widget fetchItemList(int length, list, String path) {
    List tmplist = fetchList(length, list);
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: List.generate(
            tmplist.length,
            (index) => ListTile(
                  onTap: () {
                    Navigator.pushNamed(
                        context, path + tmplist[index].id.toString());
                  },
                  leading: Text('${index + 1}'),
                  title: Text(tmplist[index].title),
                  subtitle: Text(
                    tmplist[index].title,
                    style: const TextStyle(overflow: TextOverflow.ellipsis),
                  ),
                )),
      ),
    );
  }
}
