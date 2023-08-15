import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/all_controller.dart';

class UsersPage extends StatefulWidget {
  UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final AllController controller = Get.put(AllController());

  @override
  void initState() {
    super.initState();
    controller.fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => ListView.builder(
          itemCount: controller.userData.length,
          itemBuilder: (context, index) {
            final user = controller.userData[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(user['avatar']),
              ),
              title: Text('${user['first_name']} ${user['last_name']}'),
              subtitle: Text(user['email']),
            );
          },
        ),
      ),
    );
  }
}
