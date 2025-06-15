import 'package:flutter/material.dart';
import 'menu_participante.dart';
import 'menu_admin.dart';
import 'menu_mudar_palavrapasse.dart';
import 'menu_inicial.dart';

class MenuLogin extends StatefulWidget {
  const MenuLogin({super.key});

  @override
  State<MenuLogin> createState() => _MenuLoginState();
}

class _MenuLoginState extends State<MenuLogin> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  static const Color verdeEscuro = Color(0xFF1a4d3d);
  static const Color verdeClaro = Color(0xFFA8D4BA);

  void _login() {
    String email = emailController.text;
    String password = passwordController.text;

    if (email == 'admin' && password == 'admin') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MenuAdmin()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MenuParticipante()),
      );
    }
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
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const MenuInicial()),
                    );
                  },
                ),
                const SizedBox(width: 8),
                const Text(
                  'Login',
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
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: verdeEscuro,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 48),
                      ),
                      child: const Text('Entrar'),
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                            const MenuMudarPalavraPasse(),
                          ),
                        );
                      },
                      child: const Text(
                        'Esqueceu a sua palavra passe?',
                        style: TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                        ),
                      ),
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
