import 'package:flutter/material.dart';

class MenuListaMeusEventos extends StatelessWidget {
  const MenuListaMeusEventos({super.key});

  static const Color verdeEscuro = Color(0xFF1a4d3d);
  static const Color verdeClaro = Color(0xFFA8D4BA);

  @override
  Widget build(BuildContext context) {
    final meusEventos = [
      {'titulo': 'Evento 1', 'sub': 'Subhead'},
      {'titulo': 'Evento 2', 'sub': 'Subhead'},
    ];

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

          return Container(
            margin: const EdgeInsets.only(bottom: 16),
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
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: CircleAvatar(
                backgroundColor: verdeEscuro,
                child: const Text(
                  'A',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              title: Text(evento['titulo'] ?? ''),
              subtitle: Text(evento['sub'] ?? ''),
              trailing: ElevatedButton(
                onPressed: () {
                  // lógica para cancelar inscrição
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[700],
                  foregroundColor: Colors.white,
                ),
                child: const Text('Cancelar inscrição'),
              ),
            ),
          );
        },
      ),
    );
  }
}
