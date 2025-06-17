import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ipca_gestao_eventos/models/eventos.dart';

abstract class EventosApi {
  static const String _baseUrl = 'https://ipcaeventos-cmh2evayfvghhce9.spaincentral-01.azurewebsites.net/api';

  // Obter lista de eventos
  static Future<List<Evento>> getEventos() async {
    final url = Uri.parse('$_baseUrl/evento');

    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        return responseData.map((json) => Evento.fromJson(json)).toList();
      } else {
        throw Exception('Erro ${response.statusCode}: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Erro ao carregar eventos: $e');
      rethrow;
    }
  }

  // Obter evento por ID
  static Future<Evento?> getEventoPorId(int idEvento) async {
    final url = Uri.parse('$_baseUrl/evento/$idEvento');

    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return Evento.fromJson(responseData);
      } else if (response.statusCode == 404) {
        print('Evento com ID $idEvento não encontrado.');
        return null;
      } else {
        throw Exception('Erro ${response.statusCode}: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Erro ao carregar evento por ID: $e');
      return null;
    }
  }

  // Atualizar evento existente
  static Future<void> atualizarEvento(Evento evento) async {
    final url = Uri.parse('$_baseUrl/evento/${evento.idEvento}');

    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(evento.toJson()),
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Erro ao atualizar evento: ${response.statusCode}');
    }
  }

  // Criar novo evento
  static Future<void> criarEvento(Evento evento) async {
    final url = Uri.parse('$_baseUrl/evento');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(evento.toJson()),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Erro ao criar evento: ${response.statusCode}');
    }
  }

  // Eliminar evento por ID
  static Future<void> eliminarEvento(int idEvento) async {
    final url = Uri.parse('$_baseUrl/evento/$idEvento');

    final response = await http.delete(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Erro ao eliminar evento: ${response.statusCode}');
    }
  }

  // Inscrever participante em evento
  static Future<void> inscreverParticipante({
    required int idEvento,
    required int idUtilizador,
  }) async {
    final url = Uri.parse('$_baseUrl/inscricao');

    final body = {
      "id_evento": idEvento,
      "id_utilizador": idUtilizador,
      "data_inscricao": DateTime.now().toIso8601String()
    };

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Erro ao inscrever: ${response.statusCode}');
    }
  }

  // Listar eventos onde o utilizador está inscrito
  static Future<List<Evento>> getEventosInscritosPorUtilizador(int idUtilizador) async {
    final url = Uri.parse('$_baseUrl/inscricao/utilizador/$idUtilizador');

    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      return responseData.map((json) => Evento.fromJson(json)).toList();
    } else {
      throw Exception('Erro ${response.statusCode}: ${response.reasonPhrase}');
    }
  }

  // Cancelar inscrição
  static Future<void> cancelarInscricao(int idEvento, int idUtilizador) async {
    final url = Uri.parse('$_baseUrl/inscricao/cancelar');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'id_evento': idEvento,
        'id_utilizador': idUtilizador,
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Erro ao cancelar inscrição: ${response.statusCode}');
    }
  }
}
