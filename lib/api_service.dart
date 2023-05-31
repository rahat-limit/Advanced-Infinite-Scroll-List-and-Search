import 'dart:math';

import 'package:dio/dio.dart';
import 'package:search_and_infinite_list/user_model.dart';

const String path = 'https://dummyjson.com/users';

class ApiService {
  final dio = Dio();
  List<User> list = [];
  getData({required int page, int posts_per_page = 20}) async {
    final res = await dio.get(path);
    final int pages = page * posts_per_page;
    List<dynamic> data = res.data['users'];

    if (res.statusCode == 200) {
      if (pages > data.length) {
        if (pages - data.length > 0 && pages - posts_per_page <= data.length) {
          // Some elements still in ApiServer
          for (var elem
              in data.sublist(max(pages - posts_per_page, 0), data.length)) {
            final user = User.fromJson(elem as Map<String, dynamic>);
            list.add(user);
          }
          return list;
        } else {
          // No elements left in ApiServer
          return null;
        }
      } else {
        for (var elem
            in data.sublist(max(posts_per_page * (page - 1), 0), pages)) {
          final user = User.fromJson(elem as Map<String, dynamic>);
          list.add(user);
        }
        return list;
      }
    } else {
      return null;
    }
  }
}
