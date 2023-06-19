import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.lightGreen,
      ),
      home: const AboutPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key,required title});

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 229, 1),
      appBar: AppBar(
        title: Text('Sobre o App'),
        //Color.fromRGBO(110, 207, 66, 1),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Descrição',
                style: TextStyle(
                  color: Color.fromRGBO(107, 69, 108, 1),
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'A NextDiet nasce com o intuito de resolver uma das maiores dores para aqueles que tenta manter uma dieta saudável na sua rotina, a falta de disciplina.NextDiet é um aplicativo que funcionará como um assistente na hora de calcular e montar a dieta de cada pessoa, baseado em informações passadas pelo próprio usuário (Como por exemplo a taxa metabólica diária baseado no resultado obtido na consulta com o nutrólogo ou nutricionista). Ele terá dados nutricionais de vários alimentos comuns no dia a dia, o que auxiliará o usuário a escolher o que mais o agrada de acordo com suas restrições, mantendo assim a ideia principal da aplicação, ou seja, a liberdade do usuário de poder se adaptar a rotina!',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 24.0),
              Text(
                'Objetivo',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(107, 69, 108, 1),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'O objetivo do NextDiet é facilitar e auxiliar os usuários da aplicação a seguir uma dieta totalmente personalizada de acordo com as informações passadas pelo mesmo, tendo como meta a realização dos objetivos relacionados à alimentação e à saúde, fornecendo uma plataforma para monitorar e controlar a ingestão de alimentos.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 24.0),
              Text(
                'Equipe',
                style: TextStyle(
                  color: Color.fromRGBO(107, 69, 108, 1),
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                '-  Lucas Sena Guimarães de Castro\n- Gabriel de Oliveira Barbosa\n- Samuel Quites Lopes\n- Lucas Lima Publio\n- Luiz Fernando Souza',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 24.0),
              Text(
                'Contato',
                style: TextStyle(
                  color: Color.fromRGBO(107, 69, 108, 1),
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Entre em contato conosco em:\n- Email: email@dominio.com\n- Telefone: (00) 0000-0000\n- Endereço: Rua X, Número Y, Bairro Z',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(
                height: 20,
              ),

              Container(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: 190,
                  height: 190,
                  child: Image.asset("assets/icons/Logo-nextDiet.png"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

