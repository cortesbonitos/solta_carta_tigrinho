import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pagamento.dart';

class PagamentoAPI {
  static const String baseUrl =
      'https://ipcaeventos-cmh2evayfvghhce9.spaincentral-01.azurewebsites.net/api/Pagamento';

  static Future<bool> criarPagamento(Pagamento pagamento) async {
    const baseUrl = 'https://ipcaeventos-cmh2evayfvghhce9.spaincentral-01.azurewebsites.net/api/pagamento';

    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(pagamento.toJson()),
      );

      // 🟡 ADICIONA ISTO AQUI:
      print('STATUS: ${response.statusCode}');
      print('BODY: ${response.body}');

      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print('Erro ao criar pagamento: $e');
      return false;
    }
  }


}
