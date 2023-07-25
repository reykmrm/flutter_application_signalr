import 'package:flutter/material.dart';
import 'package:flutter_application_signalr/src/pages/home/perfil/controller_perfil.dart';
import 'package:get/get.dart';

import 'controller_list_users.dart';

class ListsUsers extends StatelessWidget {
  ListsUsers({super.key});

  ControllerListUser con = Get.put(ControllerListUser());
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(() => ListView.builder(
            itemCount: con.responseApi.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(con.responseApi[index].name.toString()),
                subtitle: Text(con.responseApi[index].users.toString()),
                trailing: Text('2023-07-23'),
              );
            },
          )),
    );
  }
}
