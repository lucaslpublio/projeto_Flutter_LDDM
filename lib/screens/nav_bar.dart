import 'package:bottom_navigation_bar/screens/Info_Screen.dart';
import 'package:bottom_navigation_bar/screens/Pagina_Inicial.dart';
import 'package:bottom_navigation_bar/screens/profile_screen.dart';
import 'package:bottom_navigation_bar/screens/recomendacoes_saude.dart';
import 'package:bottom_navigation_bar/utilities/icon_path_util.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../utilities/constant.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class nav_bar extends StatefulWidget {
  final int loginValido;
  const nav_bar({Key? key, required this.loginValido}) : super(key: key);

  @override
  State<nav_bar> createState() => _nav_bar();
}

class _nav_bar extends State<nav_bar> {
  PersistentTabController? _controller;
  int? selectedIndex;

  @override
  void initState() {
    _controller = PersistentTabController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        navBarHeight: kSizeBottomNavigationBarHeight,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: kColorBNBBackground,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        popAllScreensOnTapOfSelectedTab: false,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: false,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style19,
        onItemSelected: (final index) {
          setState(() {
            _controller?.index = index;

            if (index == 1) {}
          });
        },
      ),
    );
  }

  List<Widget> _buildScreens() {
    return [
      Pagina_Inicial(loginValido: widget.loginValido),
      const InfoScreen(),
      const recomendacoes_saude(),
      const InfoScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Column(
          children: [
            SizedBox(
              height: kSizeBottomNavigationBarIconHeight,
              child: Image.asset(
                kIconPathBottomNavigationBarHome,
              ),
            ),
          ],
        ),
        inactiveIcon: Column(
          children: [
            SizedBox(
              height: kSizeBottomNavigationBarIconHeight,
              child: Image.asset(
                kIconPathBottomNavigationBarHomeDeactive,
              ),
            ),
          ],
        ),
        title: ('Home'),
        activeColorPrimary: kColorBNBActiveTitleColor,
        inactiveColorPrimary: kColorBNBDeactiveTitleColor,
      ),
      PersistentBottomNavBarItem(
        icon: Column(
          children: [
            SizedBox(
              height: kSizeBottomNavigationBarIconHeight,
              child: Image.asset(
                kIconPathBottomNavigationBarInfo,
              ),
            ),
          ],
        ),
        inactiveIcon: Column(
          children: [
            SizedBox(
              height: kSizeBottomNavigationBarIconHeight,
              child: Image.asset(
                kIconPathBottomNavigationBarInfoDeactive,
              ),
            ),
          ],
        ),
        title: ('Animals'),
        activeColorPrimary: kColorBNBActiveTitleColor,
        inactiveColorPrimary: kColorBNBDeactiveTitleColor,
      ),
      PersistentBottomNavBarItem(
        icon: Column(
          children: [
            SizedBox(
              height: kSizeBottomNavigationBarIconHeight,
              child: Image.asset(
                kIconPathBottomNavigationBarHeart,
              ),
            ),
          ],
        ),
        inactiveIcon: Column(
          children: [
            SizedBox(
              height: kSizeBottomNavigationBarIconHeight,
              child: Image.asset(
                kIconPathBottomNavigationBarHeartDeactive,
              ),
            ),
          ],
        ),
        title: ('Plants'),
        activeColorPrimary: kColorBNBActiveTitleColor,
        inactiveColorPrimary: kColorBNBDeactiveTitleColor,
      ),
      PersistentBottomNavBarItem(
        icon: Column(
          children: [
            SizedBox(
              height: kSizeBottomNavigationBarIconHeight,
              child: Image.asset(
                kIconPathBottomNavigationBarProfile,
              ),
            ),
          ],
        ),
        inactiveIcon: Column(
          children: [
            SizedBox(
              height: kSizeBottomNavigationBarIconHeight,
              child: Image.asset(
                kIconPathBottomNavigationBarProfileDeactive,
              ),
            ),
          ],
        ),
        title: ('Profile'),
        activeColorPrimary: kColorBNBActiveTitleColor,
        inactiveColorPrimary: kColorBNBDeactiveTitleColor,
      ),
    ];
  }

  _inserir(String NomeCompleto, String email, String senha) async {
    Database bd = _recuperarBD();
    Map<String, dynamic> dadosDeLogin = {
      "nomeCompleto" : NomeCompleto,
      "email" : email,
      "senha" : senha
    };
    int id = await bd.insert("usuarios", dadosDeLogin);
    print("Item Criado: $id");


  }

  _recuperarBD() async {
    final caminhoBD = await getDatabasesPath();
    final localBD = join(caminhoBD, "banco.bd");
    var retorno = await openDatabase(
        localBD,
        version: 2,
        onCreate: (db, dbVersaoRecente) {
          String sql = "CREATE TABLE usuarios ("
              "nomeCompleto VARCHAR"
              "email VARCHAR PRIMARY KEY,"
              "senha VARCHAR )";
          db.execute(sql);
        }
    );

    print("Aberto " + retorno.isOpen.toString());

  }

}