import 'package:flutter/material.dart';
import 'package:ipca_gestao_eventos/data/eventosAPI.dart';
import 'package:ipca_gestao_eventos/models/eventos.dart';
import 'menu_detalhes_evento.dart';

class MenuEventosParticipante extends StatefulWidget {
  const MenuEventosParticipante({super.key});

  @override
  State<MenuEventosParticipante> createState() => _MenuEventosParticipanteState();
}

class _MenuEventosParticipanteState extends State<MenuEventosParticipante> {
  List<Evento> _eventosGratis = [];
  List<Evento> _eventosPagos = [];
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

      for (var e in eventos) {
        final preco = 0.0; // ← substituir por e.preco quando existir no model
        if (preco == 0.0) {
          _eventosGratis.add(e);
        } else {
          _eventosPagos.add(e);
        }
      }

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _erro = e.toString();
        _isLoading = false;
      });
    }
  }

  void _irParaDetalhes(BuildContext context, Evento evento, double preco) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MenuDetalhesEvento(
          titulo: evento.titulo,
          descricao: evento.descricao,
          preco: evento.preco,
          nomeOrador: evento.nomeOrador,
          dataInicio: evento.dataInicio,
          dataFim: evento.dataFim,
          mediaAvaliacoes: evento.mediaAvaliacoes,
          limiteInscricoes: evento.limiteInscricoes,
        ),
      ),
    );

  }

  Widget _construirSecao(String titulo, List<Evento> eventos, double precoFixo) {
    if (eventos.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...eventos.map((evento) {
          return GestureDetector(
            onTap: () => _irParaDetalhes(context, evento, precoFixo),
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
                          evento.titulo,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(evento.descricao),
                  const SizedBox(height: 8),
                  Text(
                    precoFixo == 0
                        ? 'Grátis'
                        : 'Preço: ${precoFixo.toStringAsFixed(2)} €',
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
          );
        }),
        const SizedBox(height: 24),
      ],
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _erro != null
          ? Center(child: Text('Erro: $_erro'))
          : Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _construirSecao('Eventos Grátis', _eventosGratis, 0.0),
            _construirSecao('Eventos Pagos', _eventosPagos, 10.0), // ← depois troca por evento.preco
          ],
        ),
      ),
    );
  }
}
