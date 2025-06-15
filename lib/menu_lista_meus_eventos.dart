import 'package:flutter/material.dart';
import 'menu_participante.dart';
import 'menu_detalhes_meu_evento.dart';

class MenuListaMeusEventos extends StatelessWidget {
  const MenuListaMeusEventos({super.key});

  static const Color verdeEscuro = Color(0xFF1a4d3d);
  static const Color verdeClaro = Color(0xFFA8D4BA);

  final List<Map<String, dynamic>> meusEventos = const [
    {
      'titulo': 'Evento 1',
      'descricao': 'Subhead do Evento 1',
      'preco': 0.0,
    },
    {
      'titulo': 'Evento 2',
      'descricao': 'Subhead do Evento 2',
      'preco': 5.0,
    },
  ];

  void _desinscrever(BuildContext context, String titulo) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Cancelou inscrição em "$titulo".')),
    );

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const MenuParticipante()),
          (route) => false,
    );
  }

  void _abrirDetalhes(BuildContext context, Map<String, dynamic> evento) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MenuDetalhesMeuEvento(
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Meus Eventos'),
        backgroundColor: verdeEscuro,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: meusEventos.length,
        itemBuilder: (context, index) {
          final evento = meusEventos[index];

          return GestureDetector(
            onTap: () => _abrirDetalhes(context, evento),
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: verdeClaro,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.event_available),
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
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () =>
                            _desinscrever(context, evento['titulo']),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[700],
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Cancelar inscrição'),
                      ),
                    ],
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

