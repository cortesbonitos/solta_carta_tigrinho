import 'package:flutter/material.dart';
import 'menu_logout.dart';

class MenuPagamento extends StatefulWidget {
  const MenuPagamento({super.key});

  @override
  State<MenuPagamento> createState() => _MenuPagamentoState();
}

class _MenuPagamentoState extends State<MenuPagamento> {
  String? metodoSelecionado;

  static const Color verdeEscuro = Color(0xFF1a4d3d);

  final List<String> metodos = [
    'Cartão de Débito',
    'Apple Pay',
    'Google Pay',
    'MB Way',
    'PayPal',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Método de pagamento'),
        backgroundColor: verdeEscuro,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...metodos.map((metodo) => RadioListTile<String>(
              title: Text(metodo),
              value: metodo,
              groupValue: metodoSelecionado,
              activeColor: verdeEscuro,
              onChanged: (value) {
                setState(() {
                  metodoSelecionado = value;
                });
              },
            )),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: metodoSelecionado != null
                  ? () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MenuLogout()),
                );
              }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: verdeEscuro,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Confirmar'),
            ),
          ],
        ),
      ),
    );
  }
}
