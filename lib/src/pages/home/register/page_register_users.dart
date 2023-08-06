import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller_register_users.dart';

class PageRegisterUser extends StatelessWidget {
  final RegisterController _registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de Usuario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _registerController.nameController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _registerController.userController,
              decoration: InputDecoration(labelText: 'Usuario'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _registerController.passController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Contraseña'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Acción a realizar cuando se presiona el botón de enviar
                _registerController.registerUser();
              },
              child: Text('Enviar'),
            ),
          ],
        ),
      ),
    );
  }
}
