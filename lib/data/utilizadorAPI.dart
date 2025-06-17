import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/utilizador.dart';

class UtilizadorAPI {
  static const String baseUrl = 'https://ipcaeventos-cmh2evayfvghhce9.spaincentral-01.azurewebsites.net/api/utilizador';

  static Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'palavra_passe': password}), // <-- CORRETO
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        Utilizador.currentUser = Utilizador.fromJson(data);
        return true;
      } else {
        print('Login falhou: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Erro ao fazer login: $e');
      return false;
    }
  }

  static Future<void> carregarTodos() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        for (var json in jsonData) {
          final utilizador = Utilizador.fromJson(json);
          Utilizador.utilizadores[utilizador.idUtilizador] = utilizador;
        }
      } else {
        throw Exception('Erro ao buscar utilizadores: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao carregar utilizadores: $e');
      rethrow;
    }
  }
}
