import 'dart:convert';

import 'package:flutter_application_signalr/src/model/users.dart';
import 'package:get/get.dart';

import '../api/enviroment.dart';

class UsersProvider extends GetConnect {
  String url = Enviroment.api_chat + 'Users';

  Future<List<dynamic>> getAllUsers() async {
    try {
      Response response = await get(url);

      List<dynamic> jsonData = response.body;
      List<Users> usersList =
          jsonData.map((user) => Users.fromJson(user)).toList();
      // for (Users user in usersList) {
      //   print('ID: ${user.id}');
      //   print('Name: ${user.name}');
      //   print('Users: ${user.users}');
      //   print('Password: ${user.pass}');
      //   print('---------------');
      // }
      return usersList;
    } catch (error) {
      print('Error en la pai  $error');
      throw Exception('Error de conexión: $error');
    }
  }
}
