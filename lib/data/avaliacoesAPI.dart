import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ipca_gestao_eventos/models/avaliacao.dart';

class AvaliacoesAPI {
  static const String baseUrl = 'https://ipcaeventos-cmh2evayfvghhce9.spaincentral-01.azurewebsites.net/api/avaliacao';

  static Future<bool> enviarAvaliacao({
    required int idEvento,
    required int idUtilizador,
    required int nota,
    String? comentario,
  }) async {
    final Map<String, dynamic> body = {
      "id_evento": idEvento,
      "id_utilizador": idUtilizador,
      "pontuacao": nota,
      "comentario": comentario?.isNotEmpty == true ? comentario : " ",
    };

    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      print("Resposta da API: ${response.statusCode} - ${response.body}");

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print('Erro ao enviar avaliação: $e');
      return false;
    }
  }

  static Future<List<Avaliacao>> getAvaliacoes() async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Avaliacao.fromJson(json)).toList();
      } else {
        throw Exception('Erro ao obter avaliações: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao buscar avaliações: $e');
      rethrow;
    }
  }
}
