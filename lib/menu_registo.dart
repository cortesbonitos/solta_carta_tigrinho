import 'package:flutter/material.dart';
import 'menu_login.dart';
import 'menu_inicial.dart';

class MenuRegisto extends StatefulWidget {
  const MenuRegisto({super.key});

  @override
  State<MenuRegisto> createState() => _MenuRegistoState();
}

class _MenuRegistoState extends State<MenuRegisto> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmarPasswordController = TextEditingController();

  static const Color verdeEscuro = Color(0xFF1a4d3d);
  static const Color verdeClaro = Color(0xFFA8D4BA);

  void _registar() {
    final email = emailController.text;
    final password = passwordController.text;
    final confirmarPassword = confirmarPasswordController.text;

    if (password != confirmarPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('As palavras-passe não coincidem.')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Registo efetuado com sucesso.')),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const MenuLogin()),
    );
  }

  void _voltarParaInicial() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const MenuInicial()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 100,
            width: double.infinity,
            color: verdeEscuro,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: _voltarParaInicial,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Registo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(24),
                margin: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: verdeClaro,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Email'),
                    const SizedBox(height: 8),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text('Palavra passe'),
                    const SizedBox(height: 8),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text('Confirmar palavra passe'),
                    const SizedBox(height: 8),
                    TextField(
                      controller: confirmarPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _registar,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: verdeEscuro,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 48),
                      ),
                      child: const Text('Registar'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
