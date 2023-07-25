import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'perfil/page_perfil.dart';

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
            children: const [
              PagePerfil(),
              //Buscar(),
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
          // GButton(
          //   icon: Icons.person_2,
          //   text: 'buscar',
          // ),
        ],
      ),
    );
  }
}
