import 'package:bottom_navigation_bar/screens/Pagina_Inicial.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/sql/sql_connection.dart';
import 'package:intl/intl.dart';

void exibirMensagem(String mensagem, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(mensagem)),
  );
}

class RefeicoesScreen extends StatefulWidget {
  final int loginValido;
  RefeicoesScreen({Key? key, required this.loginValido}) : super(key: key);

  @override
  _RefeicoesScreenState createState() => _RefeicoesScreenState();
}

class _RefeicoesScreenState extends State<RefeicoesScreen> {
  final TextEditingController controllerRefeicoes = TextEditingController();
  final TextEditingController controllerQuantidade = TextEditingController();
  final TextEditingController controllerCalorias = TextEditingController();

  final dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    controllerRefeicoes.text = '';
    controllerQuantidade.text = '';
    controllerCalorias.text = '';
  }

  @override
  void dispose() {
    controllerRefeicoes.dispose();
    controllerQuantidade.dispose();
    controllerCalorias.dispose();
    super.dispose();
  }

  Future<void> exibirRefeicoesCadastradas() async {
    int aux = widget.loginValido;
    print("valor de aux");
    print(aux);
    List<Map<String, dynamic>> refeicoes = await dbHelper.listarRefeicoes(aux);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Refeições Cadastradas"),
          content: SingleChildScrollView(
            child: Column(
              children: refeicoes.map((refeicao) {
                DateTime dataHora = DateTime.parse(refeicao['data']);
                String dataHoraFormatada = DateFormat('dd/MM/yyyy HH:mm').format(dataHora);

                return ListTile(
                  title: Text(refeicao['refeicao']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Data e Hora: $dataHoraFormatada"),
                      Text("Quantidade: ${refeicao['quantidade']}"),
                      Text("Calorias: ${refeicao['calorias']}"),
                      Divider(),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> adicionarRefeicao() async {
    if (controllerRefeicoes.text.isNotEmpty &&
        controllerQuantidade.text.isNotEmpty &&
        controllerCalorias.text.isNotEmpty) {
      await dbHelper.inserirRefeicoes(
        widget.loginValido,
        controllerRefeicoes.text,
        double.parse(controllerQuantidade.text.replaceAll(',', '.')),
        double.parse(controllerCalorias.text.replaceAll(',', '.')),
      );
      exibirMensagem("Cadastro realizado com sucesso!", context);
    } else {
      exibirMensagem("Por favor preencha todos os campos.", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Pagina_Inicial(loginValido: widget.loginValido)));
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(
                labelText: "Refeição",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              controller: controllerRefeicoes,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: controllerQuantidade,
              decoration: const InputDecoration(
                labelText: "Quantidade (gramas)",
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
              controller: controllerCalorias,
              decoration: const InputDecoration(
                labelText: "Calorias",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: const TextStyle(fontSize: 20),
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
                onPressed: adicionarRefeicao,
                color: Colors.lightGreen,
                child: Text(
                  'ADICIONAR REFEIÇÃO',
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
            Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
              ),
              child: MaterialButton(
                onPressed: exibirRefeicoesCadastradas,
                color: Colors.blue,
                child: Text(
                  'EXIBIR REFEIÇÕES',
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
