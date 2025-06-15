import 'package:flutter/material.dart';
import 'menu_participante.dart';

class MenuDetalhesMeuEvento extends StatelessWidget {
  final String titulo;
  final String descricao;
  final double preco;

  const MenuDetalhesMeuEvento({
    super.key,
    required this.titulo,
    required this.descricao,
    required this.preco,
  });

  static const Color verdeEscuro = Color(0xFF1a4d3d);
  static const Color verdeClaro = Color(0xFFA8D4BA);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Meu Evento'),
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
                preco == 0
                    ? 'Evento Grátis'
                    : 'Preço: ${preco.toStringAsFixed(2)} €',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Inscrição cancelada com sucesso!'),
                    ),
                  );

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MenuParticipante(),
                    ),
                        (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[700],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('Cancelar inscrição'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

