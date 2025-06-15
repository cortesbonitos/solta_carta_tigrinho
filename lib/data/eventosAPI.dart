import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ipca_gestao_eventos/models/eventos.dart';

abstract class EventosApi {
  static const String _baseUrl = 'https://ipcaeventos-cmh2evayfvghhce9.spaincentral-01.azurewebsites.net/api';

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

  static Future<void> atualizarEvento(Evento evento) async {
    final url = Uri.parse('$_baseUrl/evento/${evento.idEvento}');
    final body = jsonEncode(evento.toJson());

    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      // ✅ Aceita 200 e 204 como sucesso
      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception('Erro ao atualizar evento: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao atualizar evento: $e');
      rethrow;
    }
  }
}
