import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';

import 'package:ipca_gestao_eventos/models/inscricao.dart';
abstract class InscricoesAPI {
  static const String _baseUrl = 'https://ipcaeventos-cmh2evayfvghhce9.spaincentral-01.azurewebsites.net/api';

  /// Inscreve um utilizador num evento.
  //static Future<bool> inscrever(int idUtilizador, int idEvento);

  /// Cancela a inscrição de um utilizador num evento.
//static Future<bool> cancelarInscricao(int idUtilizador, int idEvento);

  /// Obtém as inscrições de um utilizador.
  static Future<List<Inscricao>> getInscricoesPorUser(int idUtilizador) async {
    final url = Uri.parse('$_baseUrl/Inscricao');

    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        List <Inscricao> inscricoes = responseData.map((json) => Inscricao.fromJson(json)).toList();
        return inscricoes.where((i) => i.idUtilizador == idUtilizador).toList();
      } else {
        throw Exception('Erro ${response.statusCode}: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Erro ao carregar eventos: $e');
      rethrow;
    }
  }

  // Eliminar evento por ID
  static Future<void> eliminarInscricao(int idInscricao) async {
    final url = Uri.parse('$_baseUrl/Inscricao/$idInscricao');

    final response = await http.delete(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Erro ao eliminar Inscricao: ${response.statusCode}');
    }
  }

  static Future<void> criarInscricao(Inscricao inscricao) async {
    final url = Uri.parse('$_baseUrl/Inscricao');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({

          'id_utilizador': inscricao.idUtilizador,
          'id_evento': inscricao.idEvento,
          'data_inscricao':  inscricao.dataInscricao.toIso8601String(),
        }
      ),
    );

    if (response.statusCode != 201 && response.statusCode != 200) {
      print(response.body);
      throw Exception('Erro ao criar Inscricao: ${response.body}');
    }
  }

  /// Obtém as inscrições de um evento.
//static Future<List<InscricoesAPI>> obterInscricoesPorEvento(int idEvento);
}