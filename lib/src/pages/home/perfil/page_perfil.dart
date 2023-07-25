import 'package:flutter/material.dart';

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
    );
  }
}
