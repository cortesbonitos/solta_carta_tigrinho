import 'package:flutter/material.dart';
import 'menu_login.dart';
import 'menu_registo.dart';
import '1testes.dart'; // nome correto do ficheiro de testes

class MenuInicial extends StatelessWidget {
  const MenuInicial({super.key});

  static const Color verdeEscuro = Color(0xFF1a4d3d);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // BARRA VERDE NO TOPO
          Container(
            height: 80,
            width: double.infinity,
            color: verdeEscuro,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Text(
              'Bem-vindo',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // CAIXA COM OPÇÕES
          Expanded(
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(24),
                margin: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MenuLogin()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: verdeEscuro,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                      child: const Text('Login'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MenuRegisto()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: verdeEscuro,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                      child: const Text('Registo'),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // BOTÃO DE TESTE EM BAIXO
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TesteEventosPage()), // classe dentro do ficheiro 1testes.dart
                );
              },
              child: const Text(
                '🛠 Testar API',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
