import 'package:flutter/material.dart';
import 'package:ledbim_case/views/login_page.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../controller/all_controller.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AllController controller = AllController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller.currentIndex,
      builder: (context, value, child) {
        return Scaffold(
          bottomNavigationBar: SalomonBottomBar(
              currentIndex: value,
              onTap: (i) {
                controller.bottomBarChaged(i);
              },
              items: [
                /// Home
                SalomonBottomBarItem(
                  icon: const Icon(Icons.supervisor_account_rounded),
                  title: const Text("User"),
                  selectedColor: Colors.purple,
                ),

                /// Likes
                SalomonBottomBarItem(
                  icon: const Icon(Icons.today_rounded),
                  title: const Text("ToDo"),
                  selectedColor: Colors.pink,
                ),
              ]),
          appBar: AppBar(
            backgroundColor: Colors.tealAccent.shade400,
            title: Text(widget.title),
            actions: [
              IconButton(
                  onPressed: () {
                    controller.storage.delete(key: 'token');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ));
                  },
                  icon: const Icon(Icons.exit_to_app))
            ],
          ),
          body: ValueListenableBuilder(
            valueListenable: controller.currentPage,
            builder: (context, value, child) {
              return value;
            },
          ),
        );
      },
    );
  }
}
