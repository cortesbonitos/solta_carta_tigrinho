import 'package:flutter/material.dart';
import 'menu_editar_evento.dart';
import 'menu_criar_evento.dart';

class MenuEventosAdmin extends StatelessWidget {
  const MenuEventosAdmin({super.key});

  static const Color verdeEscuro = Color(0xFF1a4d3d);
  static const Color verdeClaro = Color(0xFFA8D4BA);

  final List<Map<String, dynamic>> eventos = const [
    {
      'titulo': 'Evento 1',
      'descricao': 'Descrição do evento 1',
      'preco': 0.0,
    },
    {
      'titulo': 'Evento 2',
      'descricao': 'Descrição do evento 2',
      'preco': 5.0,
    },
    {
      'titulo': 'Evento 3',
      'descricao': 'Descrição do evento 3',
      'preco': 10.0,
    },
  ];

  void _editarEvento(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const MenuEditarEvento(),
      ),
    );
  }

  void _criarEvento(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const MenuCriarEvento(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eventos (Admin)'),
        backgroundColor: verdeEscuro,
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: eventos.length,
        itemBuilder: (context, index) {
          final evento = eventos[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: verdeClaro,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.event, color: Colors.black),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        evento['titulo'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit, color: verdeEscuro),
                      onPressed: () => _editarEvento(context),
                      tooltip: 'Editar',
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(evento['descricao']),
                const SizedBox(height: 8),
                Text(
                  evento['preco'] == 0
                      ? 'Grátis'
                      : 'Preço: ${evento['preco'].toStringAsFixed(2)} €',
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _criarEvento(context),
        backgroundColor: verdeEscuro,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Criar Evento'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}