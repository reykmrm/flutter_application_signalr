import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:signalr_core/signalr_core.dart';

import '../model/users.dart';
import '../pages/home/list_users/controller_list_users.dart';

class ConexionSignalR {
  final ControllerListUser con = Get.put(ControllerListUser());
  final connection = HubConnectionBuilder()
      .withUrl(
        'http://www.danone.somee.com/userHub',
        //'https://localhost:7137/userHub',
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
        //_reconnect();
      } else {
        // La conexión nunca se estableció o se cerró intencionalmente.
        print(
            "La conexión a SignalR no se pudo establecer o se cerró intencionalmente.");
      }
    });

    try {
      await connection.start();
      _isConnected = true;
      recibeCreateUserHub();
      recibeDeleteUserHub();
      recibeUpdateUserHub();
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

  Future<void> recibeUpdateUserHub() async {
    connection.on('UpdateUserHub', (user) {
      if (user is List<dynamic>?) {
        if (user != null) {
          // Iterar a través de la lista de usuarios
          for (var userData in user) {
            if (userData is Map<String, dynamic>) {
              Get.snackbar('Notificacion', 'Actualizo un usuario');
              con.updateUserHub(Users.fromJson(userData));
            } else {
              print(
                  'Error: Uno de los elementos de la lista no es un mapa válido.');
            }
          }
        } else {
          print('Error: La lista de usuarios es null.');
        }
      } else {
        print('Error: El objeto recibido no es una lista válida.');
      }
    });
  }

  Future<void> recibeCreateUserHub() async {
    connection.on('createUserHub', (user) {
      if (user is List<dynamic>?) {
        if (user != null) {
          // Iterar a través de la lista de usuarios
          for (var userData in user) {
            if (userData is Map<String, dynamic>) {
              Get.snackbar('Notificacion', 'Nuoevo usuario');
              con.addUser(Users.fromJson(userData));
            } else {
              print(
                  'Error: Uno de los elementos de la lista no es un mapa válido.');
            }
          }
        } else {
          print('Error: La lista de usuarios es null.');
        }
      } else {
        print('Error: El objeto recibido no es una lista válida.');
      }
    });
  }

  Future<void> recibeDeleteUserHub() async {
    connection.on('deleteUserHub', (user) {
      if (user is List<dynamic>?) {
        if (user != null) {
          // Iterar a través de la lista de usuarios
          for (var userData in user) {
            if (userData is Map<String, dynamic>) {
              Get.snackbar('Notificacion', 'Se elimino un usuario');
              con.deleteUserHub(Users.fromJson(userData));
            } else {
              print(
                  'Error: Uno de los elementos de la lista no es un mapa válido.');
            }
          }
        } else {
          print('Error: La lista de usuarios es null.');
        }
      } else {
        print('Error: El objeto recibido no es una lista válida.');
      }
    });
  }
}
