import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class recomendacoes_saude extends StatelessWidget {
  const recomendacoes_saude({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: const AboutPage(title: 'recomendacoes_saude'),
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key,required title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Recomendações Gerais de Saúde',
          style: TextStyle(

          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          buildRecommendationCard(
            title: 'Mantenha-se Ativo',
            description: ' A atividade física regular é essencial para manter um estilo de vida saudável. Através do envolvimento em exercícios físicos, você pode fortalecer seu corpo, melhorar sua resistência, controlar seu peso e promover o funcionamento adequado do sistema cardiovascular. Além disso, a atividade física também é benéfica para o seu bem-estar mental, ajudando a reduzir o estresse e melhorar o humor.',
            iconData: Icons.directions_run,
            iconColor: Colors.blue,
          ),
          buildRecommendationCard(
            title: 'Tenha uma Alimentação Balanceada',
            description: 'Uma dieta equilibrada desempenha um papel fundamental na manutenção de uma vida saudável. Ao consumir uma variedade de alimentos nutritivos, você fornece ao seu corpo os nutrientes necessários para funcionar adequadamente e fortalecer o sistema imunológico.Uma alimentação balanceada deve incluir uma variedade de grupos alimentares. Priorize o consumo de frutas frescas, legumes e verduras, pois são fontes ricas em vitaminas, minerais e fibras. Opte por grãos integrais, como arroz integral, pão integral e aveia, pois são ricos em fibras e fornecem energia de forma sustentada',
            iconData: Icons.restaurant,
            iconColor: Colors.green,
          ),
          buildRecommendationCard(
            title: 'Descanse o suficiente',
            description: 'ma boa qualidade de sono desempenha um papel fundamental na manutenção de um estilo de vida saudável. Durante o sono, o corpo se recupera e se rejuvenesce, permitindo que você tenha energia e desempenho ótimos durante o dia.',
            iconData: Icons.nightlight_round,
            iconColor: Colors.purple,
          ),
          // Add more recommendation cards here
        ],
      ),
    );
  }

  Widget buildRecommendationCard({
    required String title,
    required String description,
    required IconData iconData,
    required Color iconColor,
  }) {
    return Card(
      elevation: 8.0,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(
          iconData,
          color: iconColor,
          size: 32.0,
        ),
        title: Text(
          title,
          style: GoogleFonts.montserrat(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Text(
            description,
            style: GoogleFonts.lato(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

