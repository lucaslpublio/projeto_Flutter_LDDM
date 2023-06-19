import 'package:bottom_navigation_bar/screens/profile_screen.dart';
import 'package:bottom_navigation_bar/utilities/icon_path_util.dart';
import 'package:flutter/material.dart';
import '/sql/sql_connection.dart';
import 'package:bottom_navigation_bar/screens/nav_bar.dart';

void exibirMensagem(String mensagem, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(mensagem)),
  );
}

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final TextEditingController controllerNome = TextEditingController();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerSenha = TextEditingController();
  final TextEditingController controllerPeso = TextEditingController();
  final TextEditingController controllerAltura = TextEditingController();

  final dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 190,
              height: 190,
              child: Image.asset("assets/icons/Logo-nextDiet.png"),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Nome Completo",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              controller: controllerNome,
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              controller: controllerEmail,
              decoration: const InputDecoration(
                labelText: "Email",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              keyboardType: TextInputType.text,
              controller: controllerSenha,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Senha",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: controllerPeso,
              decoration: const InputDecoration(
                labelText: "Peso(Kg)",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: controllerAltura,
              decoration: const InputDecoration(
                labelText: "Altura(Metros)",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: const TextStyle(fontSize: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Ja possui uma conta? ',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 16.0,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    print('Login');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  ProfileScreen()),
                    );
                  },
                  child: Text('Login'),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
              ),
              child: MaterialButton(
                onPressed: () async {
                  if (controllerNome.text.isNotEmpty &&
                      controllerEmail.text.isNotEmpty &&
                      controllerSenha.text.isNotEmpty &&
                      controllerPeso.text.isNotEmpty &&
                      controllerAltura.text.isNotEmpty) {
                    print("Nome Inserido: " + controllerNome.text);
                    bool emailExists = await dbHelper.emailExists(controllerEmail.text);
                    if (emailExists) {
                      exibirMensagem("Este email já está registrado.", context);
                    } else {
                      dbHelper.inserir(
                        controllerNome.text,
                        controllerEmail.text,
                        controllerSenha.text,
                        double.parse(controllerPeso.text.replaceAll(',', '.')),
                        double.parse(controllerAltura.text.replaceAll(',', '.')),
                      );
                      exibirMensagem("Cadastro realizado com sucesso!", context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
                    }
                  } else {
                    exibirMensagem("Por favor preencha todos os campos.", context);
                  }
                },
                color: Colors.lightGreen,
                child: Text(
                  'CADASTRAR',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Divider(
              color: Colors.black,
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
