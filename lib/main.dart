import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledbim_case/controller/all_controller.dart';
import 'package:ledbim_case/views/home_page.dart';
import 'package:ledbim_case/views/login_page.dart';
import 'package:ledbim_case/views/todo_list.dart';
import 'package:ledbim_case/views/user_list.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LedBim Case',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/userlist': (context) => UsersPage(),
        '/todolist': (context) => TodoListPage()
      },
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
