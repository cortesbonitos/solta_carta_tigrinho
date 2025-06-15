import 'package:flutter/material.dart';
import 'menu_pagamento_metodos.dart';
import 'menu_logout.dart';

class MenuDetalhesEvento extends StatelessWidget {
  final String titulo;
  final String descricao;
  final double preco;

  const MenuDetalhesEvento({
    super.key,
    required this.titulo,
    required this.descricao,
    required this.preco,
  });

  static const Color verdeEscuro = Color(0xFF1a4d3d);
  static const Color verdeClaro = Color(0xFFA8D4BA);

  void _inscreverOuPagar(BuildContext context) {
    if (preco > 0) {
      // Evento pago
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Evento Pago'),
          content: Text('Custa ${preco.toStringAsFixed(2)} €. Deseja avançar com o pagamento?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Fechar o diálogo
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MenuPagamentoMetodos(
                      titulo: titulo,
                      preco: preco,
                    ),
                  ),
                );
              },
              child: const Text('Sim'),
            ),
          ],
        ),
      );
    } else {
      // Evento grátis
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Inscrição feita com sucesso!')),
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const MenuLogout()),
            (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Evento'),
        backgroundColor: verdeEscuro,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: 320,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: verdeClaro,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titulo,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text(descricao),
              const SizedBox(height: 12),
              Text(
                preco == 0 ? 'Evento Grátis' : 'Preço: ${preco.toStringAsFixed(2)} €',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => _inscreverOuPagar(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: verdeEscuro,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('Inscrever-se'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
