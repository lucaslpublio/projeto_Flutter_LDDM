import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bottom_navigation_bar/screens/refeicoes.dart';
import '/sql/sql_connection.dart';

class Pagina_Inicial extends StatefulWidget {
  final int loginValido;
  Pagina_Inicial({Key? key, required this.loginValido}) : super(key: key);

  @override
  _Pagina_InicialState createState() => _Pagina_InicialState();
}

class _Pagina_InicialState extends State<Pagina_Inicial> {
  DatabaseHelper dbHelper = DatabaseHelper();
  double peso = 0.0;
  double altura = 0.0;
  double imc = 0.0;
  double totalCaloriasDia = 0;

  @override
  void initState() {
    super.initState();
    _atualizarDadosUsuario();
  }

  Future<void> _atualizarDadosUsuario() async {
    await _carregarInfoUsuario();
    await _calcularTotalCaloriasDia();
  }

  Future<void> _carregarInfoUsuario() async {
    double peso = await dbHelper.getPeso(widget.loginValido);
    double altura = await dbHelper.getAltura(widget.loginValido);
    double imc = dbHelper.calcularIMC(peso, altura);

    setState(() {
      this.peso = peso;
      this.altura = altura;
      this.imc = imc;
    });
  }

  Future<void> _calcularTotalCaloriasDia() async {
    double totalCaloriasDia =
    await dbHelper.calcularTotalCaloriasDia(widget.loginValido);

    setState(() {
      this.totalCaloriasDia = totalCaloriasDia;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.lightBlueAccent,
              Colors.lightGreenAccent,
            ],
          ),
        ),

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 70.0),
                  child: Text(
                    'Sua Página',
                    style: GoogleFonts.lobster(
                      fontSize: 40,
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Suas informações de saúde:',
                    style: GoogleFonts.anton(
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(50),
                decoration: BoxDecoration(
                  color: Colors.lightGreen,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Peso',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        Text(
                          peso != 0.0 ? '$peso kg' : 'N/A',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Altura',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        Text(
                          altura != 0.0 ? '$altura m' : 'N/A',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'IMC',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        Text(
                          imc != 0.0 ? '${imc.toStringAsFixed(2)}' : 'N/A',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Card(
                margin: EdgeInsets.all(16),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.lightGreen,
                        Colors.lightBlueAccent,
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Text(
                            'Quantidade de Calorias Consumidas Hoje:',
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Card(
                            color: Colors.lightGreen,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.lightGreen,
                              ),
                              borderRadius: const BorderRadius.all(Radius.circular(20)),
                            ),
                            child: SizedBox(
                              width: 300,
                              height: 100,
                              child: Center(
                                child: Text(
                                  '$totalCaloriasDia cal' ,
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(46.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RefeicoesScreen(loginValido: widget.loginValido),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        'Adicionar Refeições',
                        style: GoogleFonts.indieFlower(
                          fontSize: 27,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Text(
                    'Todos os direitos reservados',
                    style: GoogleFonts.indieFlower(
                      fontSize: 27,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
