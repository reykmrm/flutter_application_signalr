import 'dart:convert';

import 'package:flutter_application_signalr/src/model/users.dart';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../api/enviroment.dart';

class UsersProvider extends GetConnect {
  static const String url = '${Enviroment.api_chat}Users';

  Future<List<dynamic>> getAllUsers() async {
    try {
      var response = await get(url);

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

  Future<void> createUser(Users user) async {
    try {
      String jsonData = json.encode(user.toJson());

      final response = await post('$url/Create', jsonData);

      String result = json.decode(response.body)['result'];
      if (response.statusCode == 200) {
        Get.snackbar('Información', result);
        
      } else {
        Get.snackbar('Error', result);
      }
    } catch (error) {
      print('Error en la API: $error');
      //Get.snackbar('Error ', error);
    }
  }

  Future<void> deleteteUser(int id) async {
    try {
      final response = await delete(
        '$url/Delete/$id',
      );

      String result = json.decode(response.body)['result'];
      if (response.statusCode == 200) {
        Get.snackbar('Información', result);
      } else {
        Get.snackbar('Error', result);
      }
    } catch (error) {
      print('Error en la API: $error');
      //Get.snackbar('Error ', error);
    }
  }
}
