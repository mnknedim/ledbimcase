import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:ledbim_case/models/users_model.dart';
import 'package:ledbim_case/views/todo_list.dart';
import 'package:ledbim_case/views/user_list.dart';
import 'package:uuid/uuid.dart';

class AllController extends ChangeNotifier {
///////////////////// LOGIN CONTROLLER \\\\\\\\\\\\\\\\\\\\\

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  TextEditingController emailController =
      TextEditingController(text: 'eve.holt@reqres.in');
  TextEditingController passController =
      TextEditingController(text: 'cityslicka');

  final storage = const FlutterSecureStorage();

  Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }

  Future<bool> login() async {
    isLoading.value = true;
    bool result = false;
    final response = await http.post(
      Uri.parse('https://reqres.in/api/login'),
      body: {'email': emailController.text, 'password': passController.text},
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse.containsKey('token')) {
        final token = jsonResponse['token'];
        await storage.write(key: 'token', value: token);
        result = true;
      } else {
        // Hatalı giriş işlemleri
      }
    } else {
      // Hata durumu
    }
    isLoading.value = false;

    return result;
  }

///////////////////// NAVIGATION CONTROLLER \\\\\\\\\\\\\\\\\\\\\

  final ValueNotifier<Widget> currentPage = ValueNotifier<Widget>(UsersPage());

  final ValueNotifier<int> currentIndex = ValueNotifier<int>(0);

  void bottomBarChaged(int index) {
    currentIndex.value = index;
    if (index == 0) {
      currentPage.value = UsersPage();
    }
    if (index == 1) {
      currentPage.value = TodoListPage();
    }
  }

///////////////////// USER LIST PAGE CONTROLLER \\\\\\\\\\\\\\\\\\\\\
  var userData = <Map<String, dynamic>>[].obs;

  void fetchUserData() async {
    final response = await http.get(Uri.parse('https://reqres.in/api/users'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      userData.value = List<Map<String, dynamic>>.from(data['data']);
    }
  }

///////////////////// TODO LIST PAGE CONTROLLER \\\\\\\\\\\\\\\\\\\\\

  TextEditingController taskEditingController = TextEditingController();

  var tasks = <Task>[].obs;

  void addTask() {
    if (!taskEditingController.text.isEmpty) {
      var uuid = const Uuid().v4();
      var newTask = Task(taskEditingController.text, uuid, true);
      tasks.add(newTask);
      taskEditingController.text = "";
    }
  }

  void removeTask(int index) {
    tasks.removeAt(index);
  }
}

class Task {
  final String uuid;
  final String title;
  final bool isFinished;
  Task(this.title, this.uuid, this.isFinished);
}
