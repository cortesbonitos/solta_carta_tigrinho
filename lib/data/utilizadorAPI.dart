import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ipca_gestao_eventos/models/utilizador.dart';

abstract class UserAPI {
  static Future<bool> login(String email, String password) async {
    final url = Uri.parse('https://ipcaeventos-cmh2evayfvghhce9.spaincentral-01.azurewebsites.net/api/Utilizador/login');
    // Simulate a network call
    final response = await http.post(
      url,
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        'email': email,
        'palavra_passe': password,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      // User registered successfully
      final responseData = jsonDecode(response.body);
      Utilizador cromo = Utilizador.fromJson(responseData);
      Utilizador.currentUser = cromo; // Store the user in the static variable
      print('Login successful: ${Utilizador.currentUser.toString()}');
      return true;
    } else {
      print(response.statusCode);
      print(response.body);
      return false;
    }
  }

  static Future<bool> register(String nome, String email, String password) async {
    final url = Uri.parse('https://ipcaeventos-cmh2evayfvghhce9.spaincentral-01.azurewebsites.net/api/Utilizador');
    final response = await http.post(
      url,
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(<String, dynamic>{
        'nome': nome,
        'email': email,
        'palavra_passe': password,
        'id_tipo_utilizador': 1, // Default to 1 for regular users
        
        // 'id_tipo_utilizador': 1, // Opcional, o backend já define como 1 se não enviado
      }),
    );

    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      Utilizador cromo = Utilizador.fromJson(responseData);
      Utilizador.currentUser = cromo;
      print('Registro bem-sucedido: ${Utilizador.currentUser.toString()}');
      return true;
    } else {
      print('Erro ao registrar: ${response.statusCode}');
      print(response.body);
      return false;
    }
  }

}
