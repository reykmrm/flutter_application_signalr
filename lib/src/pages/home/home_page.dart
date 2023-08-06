import 'package:flutter/material.dart';
import 'package:flutter_application_signalr/src/pages/home/chat/page_chat.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'perfil/page_perfil.dart';
import 'register/page_register_users.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentPage = 0.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
            index: currentPage.value,
            children: [
              PagePerfil(),
              ChatScreen(),
            ],
          )),
      
      bottomNavigationBar: GNav(
        gap: 18,
        backgroundColor: Colors.blue,
        color: Colors.white,
        onTabChange: (value) {
          currentPage.value = value;
        },
        tabs: const [
          GButton(
            icon: Icons.chat,
            text: 'Chat',
          ),
          GButton(
            icon: Icons.person_2,
            text: 'Registro',
          ),
        ],
      ),
    );
  }
}
