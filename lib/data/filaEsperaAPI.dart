import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/filaEspera.dart';

class FilaEsperaAPI {
  static const String _baseUrl =
      'https://ipcaeventos-cmh2evayfvghhce9.spaincentral-01.azurewebsites.net/api/filaespera';

  static Future<void> criarEntradaFila(FilaEspera entrada) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(entrada.toJson()),
    );

    if (response.statusCode != 201 && response.statusCode != 200) {
      print("Erro ao adicionar à fila de espera: ${response.body}");
      throw Exception("Erro ao adicionar à fila de espera");
    }
  }

  static Future<List<FilaEspera>> getFilaPorEvento(int idEvento) async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList
          .map((json) => FilaEspera.fromJson(json))
          .where((f) => f.idEvento == idEvento)
          .toList();
    } else {
      throw Exception("Erro ao buscar fila de espera");
    }
  }
}
