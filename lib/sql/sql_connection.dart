import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';

class DatabaseHelper {
  // Variável para armazenar o ID do usuário logado
  int loggedUserId = 0;

  Future<Database> recuperarBD() async {
    final caminhoBD = await getDatabasesPath();
    final localBD = join(caminhoBD, "v4NextDiet.bd");
    var retorno = await openDatabase(
      localBD,
      version: 1,
      onCreate: (db, dbVersaoRecente) {
        String sql = "CREATE TABLE usuarios ("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "nomeCompleto TEXT,"
            "email TEXT UNIQUE,"
            "senha TEXT,"
            "peso REAL,"
            "altura REAL"
            ");";
        db.execute(sql);

        sql = "CREATE TABLE refeicoes ("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "idUsuario INTEGER,"
            "refeicao TEXT,"
            "quantidade REAL,"
            "calorias REAL,"
            "data TEXT,"
            "FOREIGN KEY (idUsuario) REFERENCES usuarios(id)"
            ");";
        db.execute(sql);
      },
    );

    print("Aberto " + retorno.isOpen.toString());
    return retorno;
  }

  Future<bool> emailExists(String email) async {
    Database bd = await recuperarBD();
    List<Map<String, dynamic>> result = await bd.query(
        "usuarios", where: "email = ?", whereArgs: [email]);
    return result.isNotEmpty;
  }

  Future<void> inserir(String nomeCompleto, String email, String senha, double peso, double altura) async {
    Database bd = await recuperarBD();

    var crypto = sha512.convert(utf8.encode(senha));
    String senha_crypto = crypto.toString();

    if (await emailExists(email)) {
      print("Esse Email já foi cadastrado");
      return;
    }

    Map<String, dynamic> dadosDeLogin = {
      "nomeCompleto": nomeCompleto,
      "email": email,
      "senha": senha_crypto,
      "peso": peso,
      "altura": altura,
    };
    int id = await bd.insert("usuarios", dadosDeLogin);
    print("Item Criado: $id");
  }

  Future<List<Map<String, dynamic>>> listarUsuarios() async {
    Database bd = await recuperarBD();
    List<Map<String, dynamic>> usuarios = await bd.query("usuarios");
    return usuarios;
  }

  Future<int> autenticarLogin(String email, String senha) async {
    Database bd = await recuperarBD();
    var crypto2 = sha512.convert(utf8.encode(senha));
    String crypt = crypto2.toString();

    List<Map<String, dynamic>> result = await bd.query("usuarios",
        where: "email = ? AND senha = ?", whereArgs: [email, crypt]);
    if (result.isNotEmpty) {
      // Define o ID do usuário logado
      loggedUserId = result.first['id'];
      return result.first['id'];
    } else {
      return 0;
    }
  }

  Future<void> inserirRefeicoes(
      int idUsuario, String refeicao, double quantidade, double calorias) async {
    Database bd = await recuperarBD();

    DateTime now = DateTime.now();
    String dataHora = DateFormat("yyyy-MM-dd HH:mm:ss").format(now);

    Map<String, dynamic> dadosRefeicoes = {
      "idUsuario": idUsuario,
      "refeicao": refeicao,
      "quantidade": quantidade,
      "calorias": calorias,
      "data": dataHora,
    };
    await bd.insert("refeicoes", dadosRefeicoes);
  }

  Future<List<Map<String, dynamic>>> listarRefeicoes(int idUsuario) async {
    Database bd = await recuperarBD();
    List<Map<String, dynamic>> refeicoes = await bd.query("refeicoes",
        columns: ["refeicao", "quantidade", "calorias", "data"],
        where: "idUsuario = ?",
        whereArgs: [idUsuario]);
    return refeicoes;
  }

  Future<int> getLastInsertedUserId() async {
    Database bd = await recuperarBD();
    List<Map<String, dynamic>> result = await bd.rawQuery(
        "SELECT id FROM usuarios ORDER BY id DESC LIMIT 1");
    if (result.isNotEmpty) {
      return result.first['id'];
    } else {
      return 0;
    }
  }

  // Método para obter o ID do usuário logado
  int getLoggedUserId() {
    return loggedUserId;
  }

  Future<Map<String, dynamic>> exibirInfo(int idUsuario) async {
    Database db = await recuperarBD();

    List<Map<String, dynamic>> userInfo = await db.query(
      'usuarios',
      where: 'id = ?',
      whereArgs: [idUsuario],
    );

    if (userInfo.isNotEmpty) {
      double peso = userInfo.first['peso'];
      double altura = userInfo.first['altura'];
      double imc = calcularIMC(peso, altura);

      print('Peso: $peso, Altura: $altura, IMC: $imc');

      return {
        'peso': peso,
        'altura': altura,
        'imc': imc,
      };
    } else {
      return {
        'peso': 0,
        'altura': 0,
        'imc': 0,
      };
    }
  }

  double calcularIMC(double peso, double altura) {
    print("Altura = ");
    print(altura);
    print("Peso = ");
    print(peso);
    double imc = peso / (altura * altura);
    return imc;
  }

  Future<double> getPeso(int idUsuario) async {
    Database db = await recuperarBD();

    List<Map<String, dynamic>> userInfo = await db.query(
      'usuarios',
      where: 'id = ?',
      whereArgs: [idUsuario],
    );

    if (userInfo.isNotEmpty) {
      double peso = userInfo.first['peso'];
      return peso;
    } else {
      return 0;
    }
  }

  Future<double> getAltura(int idUsuario) async {
    Database db = await recuperarBD();

    List<Map<String, dynamic>> userInfo = await db.query(
      'usuarios',
      where: 'id = ?',
      whereArgs: [idUsuario],
    );

    if (userInfo.isNotEmpty) {
      double altura = userInfo.first['altura'];
      return altura;
    } else {
      return 0;
    }
  }

  Future<double> calcularTotalCaloriasDia(int idUsuario) async {
    Database db = await recuperarBD();

    DateTime now = DateTime.now();
    String formattedDate = DateFormat("yyyy-MM-dd").format(now);

    List<Map<String, dynamic>> refeicoes = await db.rawQuery(
      'SELECT SUM(calorias) AS total_calorias FROM refeicoes WHERE idUsuario = ? AND DATE(data) = ?',
      [idUsuario, formattedDate],
    );

    if (refeicoes.isNotEmpty) {
      double totalCalorias = refeicoes.first['total_calorias'] ?? 0;
      return totalCalorias;
    } else {
      return 0;
    }
  }
}
