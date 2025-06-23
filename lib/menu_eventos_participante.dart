import 'package:flutter/material.dart';
import 'package:ipca_gestao_eventos/data/eventosAPI.dart';
import 'package:ipca_gestao_eventos/data/avaliacoesAPI.dart';
import 'package:ipca_gestao_eventos/data/utilizadorAPI.dart';
import 'package:ipca_gestao_eventos/data/inscricoesAPI.dart';
import 'package:ipca_gestao_eventos/data/filaEsperaAPI.dart';
import 'package:ipca_gestao_eventos/models/eventos.dart';
import 'package:ipca_gestao_eventos/models/avaliacao.dart';
import 'package:ipca_gestao_eventos/models/utilizador.dart';
import 'menu_detalhes_evento.dart';

class MenuEventosParticipante extends StatefulWidget {
  const MenuEventosParticipante({super.key});

  @override
  State<MenuEventosParticipante> createState() => _MenuEventosParticipanteState();
}

class _MenuEventosParticipanteState extends State<MenuEventosParticipante> {
  List<Evento> _eventosAtivos = [];
  List<Evento> _eventosExpirados = [];
  Map<int, List<Avaliacao>> _avaliacoesPorEvento = {};
  bool _isLoading = true;
  String? _erro;

  static const Color verdeEscuro = Color(0xFF1a4d3d);
  static const Color verdeClaro = Color(0xFFA8D4BA);

  @override
  void initState() {
    super.initState();
    _carregarTudo();
  }

  Future<void> _carregarTudo() async {
    try {
      await UtilizadorAPI.carregarTodos();
      await _carregarEventos();
    } catch (e) {
      setState(() {
        _erro = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _carregarEventos() async {
    try {
      final eventos = await EventosApi.getEventos();
      final avaliacoes = await AvaliacoesAPI.getAvaliacoes();
      final inscricoes = await InscricoesAPI.getInscricoesPorUser(Utilizador.currentUser!.idUtilizador);
      final filaEspera = await FilaEsperaAPI.getFilaPorUtilizador(Utilizador.currentUser!.idUtilizador);

      final idsInscritos = inscricoes.map((i) => i.idEvento).toSet();
      final idsFila = filaEspera.map((f) => f.idEvento).toSet();

      final agora = DateTime.now();

      for (var e in eventos) {
        if (idsInscritos.contains(e.idEvento)) continue;
        if (idsFila.contains(e.idEvento)) continue;

        if (e.dataFim.isAfter(agora)) {
          _eventosAtivos.add(e);
        } else {
          _eventosExpirados.add(e);
        }
      }

      for (var a in avaliacoes) {
        _avaliacoesPorEvento.putIfAbsent(a.idEvento, () => []).add(a);
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

  void _irParaDetalhes(BuildContext context, Evento evento) {
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
          idEvento: evento.idEvento,
          categoria: evento.categoria,
          localizacao: evento.localizacao,
        ),
      ),
    ).then((_) {
      _eventosAtivos.clear();
      _eventosExpirados.clear();
      _carregarTudo();
    });
  }

  Widget _construirSecao(String titulo, List<Evento> eventos, {bool expirado = false}) {
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
          final avaliacoes = _avaliacoesPorEvento[evento.idEvento] ?? [];

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
                    evento.preco <= 0
                        ? 'Grátis'
                        : 'Preço: ${evento.preco.toStringAsFixed(2)} €',
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                  if (expirado && avaliacoes.isNotEmpty) ...[
                    const Divider(height: 20),
                    const Text('Avaliações:', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    ...avaliacoes.map((a) {
                      final user = Utilizador.utilizadores[a.idUtilizador];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(user?.nome ?? 'Utilizador #${a.idUtilizador}'),
                            Row(
                              children: List.generate(5, (i) => Icon(
                                i < a.pontuacao ? Icons.star : Icons.star_border,
                                color: Colors.amber,
                                size: 18,
                              )),
                            ),
                            if (a.comentario != null && a.comentario!.isNotEmpty)
                              Text('"${a.comentario!}"'),
                          ],
                        ),
                      );
                    }),
                  ],
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
            _construirSecao('Eventos Ativos', _eventosAtivos),
            _construirSecao('Eventos Expirados', _eventosExpirados, expirado: true),
          ],
        ),
      ),
    );
  }
}
