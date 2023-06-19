import 'package:bottom_navigation_bar/screens/nav_bar.dart';

import '../screens/main_screen.dart';
import 'package:flutter/material.dart';
import '/sql/sql_connection.dart';
import 'package:bottom_navigation_bar/screens/Pagina_Inicial.dart';

void exibirMensagem(String mensagem, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(mensagem)),
  );
}

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  final TextEditingController ControllerEmail = TextEditingController();
  final TextEditingController ControllerSenha = TextEditingController();

  final dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 229, 1),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: 190,
                  height: 190,
                  child: Image.asset("assets/icons/Logo-nextDiet.png"),
                ),
                SizedBox(
                  height: 20,
                ),

                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: ControllerEmail,
                  decoration: InputDecoration(
                    labelText: 'Email Address',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: ControllerSenha,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: Icon(Icons.remove_red_eye),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        print('Forgotted Password!');
                      },
                      child: Text(
                        'Esqueceu sua senha?',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.4),
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
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
                      String email = ControllerEmail.text;
                      String senha = ControllerSenha.text;

                      if (email.isEmpty || senha.isEmpty) {
                        // Verifica se o usuário preencheu os campos de email e senha
                        exibirMensagem('Preencha os campos de email e senha!', context);
                        return;
                      }

                      int loginValido = await dbHelper.autenticarLogin(email, senha);
                      if (loginValido != 0) {
                        // Se as credenciais estiverem corretas, exibe uma mensagem de login bem-sucedido
                        print('Login bem-sucedido!');
                        Navigator.push(context, MaterialPageRoute(builder: (context) => nav_bar(loginValido: loginValido)));
                      } else {
                        // Se as credenciais estiverem incorretas, exibe uma mensagem de erro
                        exibirMensagem('Email ou senha incorretos!', context);
                      }
                    },
                    color: Colors.lightGreen,
                    child: Text(
                      'LOGIN',
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
                  height: 0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '''Nao tem uma conta? ''',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                        fontSize: 16.0,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        print('Cadastre-se');
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MainScreen()),
                        );
                      },
                      child: Text('Cadastre-se'),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}