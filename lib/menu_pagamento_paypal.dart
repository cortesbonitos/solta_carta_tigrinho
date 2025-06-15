import 'package:flutter/material.dart';
import 'menu_logout.dart';

class MenuPagamentoPaypal extends StatefulWidget {
  final String titulo;
  final double preco;

  const MenuPagamentoPaypal({
    super.key,
    required this.titulo,
    required this.preco,
  });

  @override
  State<MenuPagamentoPaypal> createState() => _MenuPagamentoPaypalState();
}

class _MenuPagamentoPaypalState extends State<MenuPagamentoPaypal> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  static const Color verdeEscuro = Color(0xFF1a4d3d);
  static const Color verdeClaro = Color(0xFFA8D4BA);

  void _confirmarPagamento() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos.')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Pagamento PayPal simulado com sucesso!')),
    );

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const MenuLogout()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagamento via PayPal'),
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
                'Evento: ${widget.titulo}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text('Total: ${widget.preco.toStringAsFixed(2)} €'),
              const SizedBox(height: 24),
              const Text(
                'Simulação de login PayPal',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email PayPal',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Palavra-passe',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _confirmarPagamento,
                style: ElevatedButton.styleFrom(
                  backgroundColor: verdeEscuro,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(48),
                ),
                child: const Text('Confirmar com PayPal'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
