import 'package:flutter/material.dart';
import 'menu_logout.dart';
import 'menu_pagamento.dart';
import 'menu_detalhes_evento.dart';

class MenuEventosParticipante extends StatelessWidget {
  const MenuEventosParticipante({super.key});

  static const Color verdeEscuro = Color(0xFF1a4d3d);
  static const Color verdeClaro = Color(0xFFA8D4BA);

  @override
  Widget build(BuildContext context) {
    final eventos = [
      {
        'titulo': 'Evento 1',
        'sub': 'Subhead',
        'pago': false,
        'descricao': 'Um evento gratuito com várias atividades.',
        'data': '12/06/2025',
        'hora': '15:00',
        'local': 'Auditório 1'
      },
      {
        'titulo': 'Evento 2',
        'sub': 'Subhead',
        'pago': false,
        'descricao': 'Sessão interativa com convidados.',
        'data': '14/06/2025',
        'hora': '10:30',
        'local': 'Sala 5'
      },
      {
        'titulo': 'Evento 3',
        'sub': 'Subhead',
        'pago': true,
        'descricao': 'Workshop especial com material incluído.',
        'data': '20/06/2025',
        'hora': '09:00',
        'local': 'Centro de Convenções'
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Eventos Disponíveis'),
        backgroundColor: verdeEscuro,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: eventos.length,
        itemBuilder: (context, index) {
          final evento = eventos[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MenuDetalhesEvento(
                    titulo: evento['titulo'] as String,
                    descricao: evento['descricao'] as String,
                    data: evento['data'] as String,
                    hora: evento['hora'] as String,
                    local: evento['local'] as String,
                  ),
                ),
              );
            },
            child: Container(
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
                  child: const Text('A', style: TextStyle(color: Colors.white)),
                ),
                title: Text(evento['titulo'] as String),
                subtitle: Text(evento['sub'] as String),
                trailing: ElevatedButton(
                  onPressed: () {
                    if (evento['pago'] == true) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MenuPagamento()),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MenuLogout()),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: verdeEscuro,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Inscrever-se'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
