import 'package:flutter/material.dart';
import 'menu_login.dart';
import 'menu_participante.dart';

class MenuLogout extends StatelessWidget {
  const MenuLogout({super.key});

  static const Color verdeEscuro = Color(0xFF1a4d3d);
  static const Color verdeClaro = Color(0xFFA8D4BA);

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
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Text(
              'Logout',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Center(
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
                    const Text(
                      'Deseja sair da conta?',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (_) => const MenuLogin()),
                                  (route) => false,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: verdeEscuro,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Sim'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (_) => const MenuParticipante()),
                                  (route) => false,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Não'),
                        ),
                      ],
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
