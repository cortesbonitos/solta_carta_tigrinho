import 'package:flutter/material.dart';
import 'menu_detalhes_evento.dart';

class MenuEventosParticipante extends StatelessWidget {
  const MenuEventosParticipante({super.key});

  static const Color verdeEscuro = Color(0xFF1a4d3d);
  static const Color verdeClaro = Color(0xFFA8D4BA);

  final List<Map<String, dynamic>> eventos = const [
    {
      'titulo': 'Evento Grátis 1',
      'descricao': 'Descrição do evento grátis 1',
      'preco': 0.0,
    },
    {
      'titulo': 'Evento Grátis 2',
      'descricao': 'Descrição do evento grátis 2',
      'preco': 0.0,
    },
    {
      'titulo': 'Evento Pago 1',
      'descricao': 'Descrição do evento pago',
      'preco': 10.0,
    },
  ];

  void _irParaDetalhes(BuildContext context, Map<String, dynamic> evento) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MenuDetalhesEvento(
          titulo: evento['titulo'],
          descricao: evento['descricao'],
          preco: evento['preco'],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eventos'),
        backgroundColor: verdeEscuro,
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: eventos.length,
        itemBuilder: (context, index) {
          final evento = eventos[index];
          return GestureDetector(
            onTap: () => _irParaDetalhes(context, evento),
            child: Container(
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
                      )
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
            ),
          );
        },
      ),
    );
  }
}
