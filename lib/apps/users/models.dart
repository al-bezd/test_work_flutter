import 'package:users/apps/albums/models.dart';
import 'package:users/apps/posts/models.dart';
import 'package:users/apps/users/urls.dart';

class Base {
  Base.init(val) {
    response = val;
  }

  /// это поле нужно что бы хранить ответ сервера, что бы видеть что отдал сервер в полном объеме, очень удобно в процессе разработки, для пролакшена излишне
  var response;
}

class User extends Base {
  User.init(val) : super.init(val) {
    id = val['id'];
    name = val['name'];
    username = val['username'];
    email = val['email'];
    phone = val['phone'];
    website = val['website'];
    address = val['address'] == null ? null : Address.init(val['address']);
    company = val['company'] == null ? null : Company.init(val['company']);
  }

  static fetchPosts(int id) async {
    var tmp = await fetchPostsById(id);
    return List.generate(tmp.length, (index) => Post.init(tmp[index]));
  }

  static fetchAlbums(int id) async {
    var tmp = await fetchAlbumsById(id);
    return List.generate(tmp.length, (index) => Album.init(tmp[index]));
  }

  late int id;
  late String name;
  late String username;
  late String email;
  late String phone;
  late String website;
  Address? address;
  Company? company;
  List<Post> posts = [];
  List<Album> albums = [];
}

class Address extends Base {
  Address.init(val) : super.init(val) {
    street = val['street'];
    suite = val['suite'];
    city = val['city'];
    zipcode = val['zipcode'];
    geo = val['geo'] == null ? null : Geo.init(val['geo']);
  }
  String? street;
  String? suite;
  String? city;
  String? zipcode;
  Geo? geo;
}

class Geo extends Base {
  Geo.init(val) : super.init(val) {
    lat = double.parse(val['lat']);
    lng = double.parse(val['lng']);
  }
  late double lat;
  late double lng;
}

class Company extends Base {
  Company.init(val) : super.init(val) {
    name = val['name'];
    catchPhrase = val['catchPhrase'];
    bs = val['bs'];
  }
  late String name;
  late String catchPhrase;
  late String bs;
}
