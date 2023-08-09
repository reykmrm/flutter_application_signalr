import 'package:flutter/material.dart';
import 'package:flutter_application_signalr/src/pages/home/perfil/controller_perfil.dart';
import 'package:get/get.dart';

import 'controller_list_users.dart';

class ListsUsers extends StatelessWidget {
  ControllerListUser con = Get.put(ControllerListUser());

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(() {
        final isDeleteButtonVisible = con.showDeleteButtonIndex.value != -1;

        return Column(
          mainAxisAlignment:
              MainAxisAlignment.end, // Alineamos el texto a la izquierda
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isDeleteButtonVisible)
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .start, // Alineamos el texto a la izquierda
                children: [
                  TextButton(
                    onPressed: () {
                      con.hideDeleteButton(); // Ocultar el botón después de cancelar
                    },
                    child: Text(
                      'Cancelar',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            Expanded(
              child: ListView.builder(
                itemCount: con.responseApi.length,
                itemBuilder: (context, index) {
                  final item = con.responseApi[index];
                  final isCurrentIndex =
                      con.showDeleteButtonIndex.value == index;

                  return Column(
                    children: [
                      ListTile(
                        title: Text(item.name.toString()),
                        subtitle: Text(item.users.toString()),
                        trailing: isCurrentIndex
                            ? IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  con.deleteUser(index);
                                },
                              )
                            : Text('2023-07-23'),
                        onLongPress: () {
                          con.showDeleteButtonForIndex(index);
                        },
                        onTap: () {
                          Get.snackbar(
                              'Mensaje', 'el id seleccionado es $index');
                        },
                        leading: Icon(Icons
                            .person), // Mantener el ícono de persona en el leading
                      ),
                      const Divider(
                        height: 20,
                        thickness: 1,
                        indent: 60,
                        endIndent: 0,
                        color: Colors.white,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
