import 'package:flutter/material.dart';
import 'menu_pagamento_paypal.dart';

class MenuPagamentoMetodos extends StatefulWidget {
  final String titulo;
  final double preco;
  final int idEvento;

  const MenuPagamentoMetodos({
    super.key,
    required this.titulo,
    required this.preco,
    required this.idEvento,
  });

  @override
  State<MenuPagamentoMetodos> createState() => _MenuPagamentoMetodosState();
}

class _MenuPagamentoMetodosState extends State<MenuPagamentoMetodos> {
  String? metodoSelecionado;

  static const Color verdeEscuro = Color(0xFF1a4d3d);
  static const Color verdeClaro = Color(0xFFA8D4BA);

  final List<String> metodos = ['PayPal']; // Apenas PayPal disponível

  void _confirmarPagamento() {
    if (metodoSelecionado == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecione um método de pagamento.')),
      );
      return;
    }

    // Avançar para ecrã de pagamento (login PayPal simulado)
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MenuPagamentoPaypal(
          titulo: widget.titulo,
          preco: widget.preco,
          idEvento: widget.idEvento,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagamento'),
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
            children: [
              Text(
                widget.titulo,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text('Preço: ${widget.preco.toStringAsFixed(2)} €'),
              const SizedBox(height: 24),
              const Text('Selecione um método de pagamento:'),
              const SizedBox(height: 12),
              ...metodos.map((metodo) {
                return RadioListTile(
                  title: Text(metodo),
                  value: metodo,
                  groupValue: metodoSelecionado,
                  onChanged: (value) {
                    setState(() {
                      metodoSelecionado = value;
                    });
                  },
                );
              }).toList(),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _confirmarPagamento,
                style: ElevatedButton.styleFrom(
                  backgroundColor: verdeEscuro,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('Confirmar Pagamento'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
