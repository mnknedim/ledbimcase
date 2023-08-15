import 'package:flutter/material.dart';
import 'package:ledbim_case/controller/all_controller.dart';
import 'package:ledbim_case/main.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AllController controller = AllController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<String?>(
        future: controller.getToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasData && snapshot.data != null) {
            return const MyHomePage(title: 'LedBim Case');
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    decoration: const InputDecoration(labelText: 'Email'),
                    controller: controller.emailController,
                  ),
                  TextField(
                    decoration: const InputDecoration(labelText: 'Password'),
                    controller: controller.emailController,
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await controller.login().then((value) {
                        if (value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const MyHomePage(title: 'LedBim Case'),
                              ));
                        }
                      });
                    },
                    child: const Text('Login'),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ValueListenableBuilder(
                    valueListenable: controller.isLoading,
                    builder:
                        (BuildContext context, dynamic value, Widget? child) {
                      return Visibility(
                          visible: value,
                          child: const CircularProgressIndicator());
                    },
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
