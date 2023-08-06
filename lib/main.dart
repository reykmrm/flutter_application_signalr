import 'package:flutter/material.dart';
import 'package:flutter_application_signalr/src/pages/home/register/page_register_users.dart';
import 'package:get/get.dart';
import 'src/pages/home/home_page.dart';
import 'src/pages/home/perfil/page_perfil.dart';
import 'src/providers/conexion_signalr.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Create an instance of ChatHubService
    final chatHubService = ConexionSignalR();

    // Open the SignalR connection when the app starts
    chatHubService.openSignalRConnection();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: '/home',
      getPages: [
        GetPage(name: '/home', page: () => const HomePage()),
        GetPage(name: '/register_user', page: () => PageRegisterUser()),
        // GetPage(name: "/fourth", page: () => Fourth()),
      ],
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
      ),
      navigatorKey: Get.key,
    );
  }
}
