import 'package:flutter/material.dart';
import 'package:signalr_core/signalr_core.dart';

import 'api/signalr_service.dart';



void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Create an instance of ChatHubService
    final chatHubService = ChatHubService();

    // Open the SignalR connection when the app starts
    chatHubService.openSignalRConnection();

    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: const Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}
