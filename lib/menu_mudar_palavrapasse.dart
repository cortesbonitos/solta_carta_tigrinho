import 'package:flutter/material.dart';

class MenuMudarPalavraPasse extends StatefulWidget {
  const MenuMudarPalavraPasse({super.key});

  @override
  State<MenuMudarPalavraPasse> createState() => _MenuMudarPalavraPasseState();
}

class _MenuMudarPalavraPasseState extends State<MenuMudarPalavraPasse> {
  final TextEditingController emailController = TextEditingController();

  static const Color verdeEscuro = Color(0xFF1a4d3d);
  static const Color verdeClaro = Color(0xFFA8D4BA);

  void _enviarEmail() {
    String email = emailController.text.trim();

    if (email.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Link de recuperação enviado para o email.'),
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.pop(context); // Volta para o login
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, insira um email válido.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Recuperar Palavra-passe'),
        backgroundColor: verdeEscuro,
      ),
      body: Center(
        child: Container(
          width: 320, // 🔧 largura mais controlada
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: verdeClaro,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 6,
                offset: const Offset(0, 3),
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Email', style: TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(height: 8),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Digite seu email',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _enviarEmail,
                style: ElevatedButton.styleFrom(
                  backgroundColor: verdeEscuro,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
