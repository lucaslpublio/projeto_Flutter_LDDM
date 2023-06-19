import 'package:bottom_navigation_bar/screens/Info_Screen.dart';
import 'package:bottom_navigation_bar/screens/home_screen.dart';
import 'package:bottom_navigation_bar/screens/profile_screen.dart';
import 'package:bottom_navigation_bar/utilities/icon_path_util.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../utilities/constant.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '/sql/sql_connection.dart';



class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PersistentTabController? _controller;
  int? selectedIndex;
  DatabaseHelper dbHelper = DatabaseHelper(); // Cria uma instância da classe DatabaseHelper

  @override
  void initState() {
    _controller = PersistentTabController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dbHelper.listarUsuarios().then((usuarios) {
      usuarios.forEach((usuario) => print(usuario));
    });
    return Scaffold(
      body: HomeScreen(),
    );
  }

}



