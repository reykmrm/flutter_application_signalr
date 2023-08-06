import 'package:flutter/cupertino.dart';
import 'package:flutter_application_signalr/src/model/users.dart';
import 'package:flutter_application_signalr/src/providers/users_provider.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  // Controladores para los campos de texto
  TextEditingController nameController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();
  UsersProvider usersProvider = UsersProvider();

  // Función para registrar al usuario
  void registerUser() {
    Users user = Users();
    user.name = nameController.text.toString();
    user.users = userController.text.toString();
    user.pass = passController.text.toString();
    usersProvider.createUser(user);
    Get.back();
  }
}
