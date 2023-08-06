import 'package:get/get.dart';
import 'package:flutter_application_signalr/src/model/users.dart';
import '../../../providers/users_provider.dart';

class ControllerListUser extends GetxController {
  RxList<Users> responseApi = RxList<Users>();
  UsersProvider usersProvider = UsersProvider();

  // Variable observable para rastrear el índice del elemento en el que se muestra el botón de eliminar
  final showDeleteButtonIndex = RxInt(-1);

  @override
  void onInit() {
    super.onInit();
    getAllUsers();
  }

  // Método para mostrar el botón de eliminar para un índice específico
  void showDeleteButtonForIndex(int index) {
    showDeleteButtonIndex.value = index;
  }

  // Método para ocultar el botón de eliminar
  void hideDeleteButton() {
    showDeleteButtonIndex.value = -1;
  }

  Future<void> getAllUsers() async {
    try {
      var user = await usersProvider.getAllUsers();
      responseApi.addAll(user as Iterable<Users>);

      for (Users user in responseApi) {
        print('ID: ${user.id}');
        print('Name: ${user.name}');
        print('Users: ${user.users}');
        print('Password: ${user.pass}');
        print('---------------');
      }
      update();
    } catch (error) {
      // Manejar el error si algo sale mal en la solicitud HTTP
      print('Error al obtener los usuarios: $error');
    }
  }

  void deleteUser(int indexUser) {
    hideDeleteButton();
    var id = responseApi[indexUser].id;
    usersProvider.deleteteUser(id!);
  }

  void editUser(int index) {
    Get.snackbar('title', 'message');
  }

  // Método para agregar un nuevo usuario a la lista
  void addUser(Users newUser) {
    responseApi.add(newUser);
    update(); // Notificar a GetX que la lista ha cambiado
  }

  void updateUserHub(Users newUser) {
    final index = responseApi.indexWhere((user) => user.id == newUser.id);
    if (index != -1) {
      responseApi[index] = newUser;
      update(); // Notificar a GetX que la lista ha cambiado
    } else {
      print('Usuario no encontrado en la lista.');
    }
  }

  void deleteUserHub(Users userToRemove) {
    responseApi.removeWhere((user) => user.id == userToRemove.id);
    update(); // Notificar a GetX que la lista ha cambiado
  }
}
