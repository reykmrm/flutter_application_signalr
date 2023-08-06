import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../list_users/page_list_users.dart';

class PagePerfil extends StatelessWidget {
  const PagePerfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuarios'),
      ),
      body: Center(
        child: ListsUsers(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/register_user');
        },
        child: Icon(Icons.add), // Icono del botón flotante
        backgroundColor: Colors.blue, // Color de fondo del botón flotante
      ),
    );
  }
}
