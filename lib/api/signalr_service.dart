import 'package:flutter/foundation.dart';
import 'package:signalr_core/signalr_core.dart';

class ChatHubService {
  final connection = HubConnectionBuilder()
      .withUrl(
        'https://localhost:7137/userHub',
        HttpConnectionOptions(
          logging: (level, message) => print(message),
        ),
      )
      .build();

  bool _isConnected = false;

  // Connect to SignalR and handle automatic reconnection on close
  Future<void> openSignalRConnection() async {
    connection.onclose((error) {
      if (_isConnected) {
        // La conexión se ha cerrado después de estar previamente conectada.
        print("La conexión a SignalR se ha cerrado. Intentando reconectar...");
        _isConnected = false;
        _reconnect();
      } else {
        // La conexión nunca se estableció o se cerró intencionalmente.
        print("La conexión a SignalR no se pudo establecer o se cerró intencionalmente.");
      }
    });

    try {
      await connection.start();
      _isConnected = true;
      print("Conexión establecida...");
    } catch (ex) {
      print("Error al conectar a SignalR: $ex");
      _isConnected = false;
    }
  }

  // Intentar reconectar con un retardo cuando la conexión se cierra inesperadamente
  void _reconnect() {
    if (!_isConnected) {
      Future.delayed(Duration(seconds: 2), () async {
        try {
          await connection.start();
          //_isConnected = true;
          print("Reconexión exitosa...");
        } catch (ex) {
          print("Error en la reconexión: $ex");
          _isConnected = false;
          _reconnect(); // Intentar reconexión nuevamente después de un retardo
        }
      });
    }
  }
}
