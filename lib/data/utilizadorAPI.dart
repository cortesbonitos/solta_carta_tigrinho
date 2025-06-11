import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ipca_gestao_eventos/models/utilizador.dart';

abstract class UserAPI {
  static Future<bool> login(String email, String password) async {
    final url = Uri.parse('??????');
    // Simulate a network call
    final response = await http.post(
      url,
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        'Email': email,
        'palavra_passe': password,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      // User registered successfully
      final responseData = jsonDecode(response.body);
      Utilizador cromo = Utilizador.fromJson(responseData);
      print(cromo.toString());
      return true;
    } else {
      //falhou
      return false;
    }
  }
}
