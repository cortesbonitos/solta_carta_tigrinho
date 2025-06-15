import 'package:flutter/material.dart';
import 'package:ipca_gestao_eventos/data/eventosAPI.dart';
import 'package:ipca_gestao_eventos/models/eventos.dart';
import 'menu_editar_evento.dart';
import 'menu_criar_evento.dart';

class MenuEventosAdmin extends StatefulWidget {
  const MenuEventosAdmin({super.key});

  @override
  State<MenuEventosAdmin> createState() => _MenuEventosAdminState();
}

class _MenuEventosAdminState extends State<MenuEventosAdmin> {
  List<Evento> _eventos = [];
  bool _isLoading = true;
  String? _erro;

  static const Color verdeEscuro = Color(0xFF1a4d3d);
  static const Color verdeClaro = Color(0xFFA8D4BA);

  @override
  void initState() {
    super.initState();
    _carregarEventos();
  }

  Future<void> _carregarEventos() async {
    try {
      final eventos = await EventosApi.getEventos();
      setState(() {
        _eventos = eventos;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _erro = e.toString();
        _isLoading = false;
      });
    }
  }

  void _editarEvento(BuildContext context, Evento evento) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MenuEditarEvento(
          idEvento: evento.idEvento,
          titulo: evento.titulo,
          descricao: evento.descricao,
          preco: evento.preco,
        ),
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _erro != null
          ? Center(child: Text('Erro: $_erro'))
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _eventos.length,
        itemBuilder: (context, index) {
          final evento = _eventos[index];

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
                        evento.titulo,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit, color: verdeEscuro),
                      onPressed: () => _editarEvento(context, evento),
                      tooltip: 'Editar',
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(evento.descricao),
                const SizedBox(height: 8),
                Text(
                  evento.preco == 0
                      ? 'Grátis'
                      : 'Preço: ${evento.preco.toStringAsFixed(2)} €',
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
