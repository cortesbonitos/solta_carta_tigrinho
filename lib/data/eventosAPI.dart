import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:ipca_gestao_eventos/models/eventos.dart';

abstract class Eventosapi {
  static Future<List<Evento>> getEventos() async {
    final url = Uri.parse('localhost');

    final response = await http.get(
      url,
      headers: <String, String>{'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // Sucesso
      final List<dynamic> responseData = jsonDecode(response.body);
      List<Evento> eventos = responseData
          .map((json) => Evento.fromJson(json))
          .toList();
      return eventos;
    } else {
      // Falhou
      throw Exception('Falha ao carregar eventos');
    }
  }
}
