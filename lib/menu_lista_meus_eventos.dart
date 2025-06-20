import 'package:flutter/material.dart';
import 'package:ipca_gestao_eventos/data/eventosAPI.dart';
import 'package:ipca_gestao_eventos/data/inscricoesAPI.dart';
import 'package:ipca_gestao_eventos/models/eventos.dart';
import 'package:ipca_gestao_eventos/models/inscricao.dart';
import 'package:ipca_gestao_eventos/models/utilizador.dart';
import 'menu_detalhes_meu_evento.dart';
import 'menu_avaliacao.dart';
import 'menu_detalhes_evento.dart';


class MenuListaMeusEventos extends StatefulWidget {
  const MenuListaMeusEventos({super.key});

  @override
  State<MenuListaMeusEventos> createState() => _MenuListaMeusEventosState();
}

class _MenuListaMeusEventosState extends State<MenuListaMeusEventos> {
  static const Color verdeEscuro = Color(0xFF1a4d3d);
  static const Color verdeClaro = Color(0xFFA8D4BA);
  final idUtilizador = Utilizador.currentUser!.idUtilizador;

  List<Evento> _eventosFuturos = [];
  List<Evento> _eventosPassados = [];
  List<Inscricao> _inscricoes = [];
  bool _loading = true;
  String? _erro;

  @override
  void initState() {
    super.initState();
    _carregarEventosInscritos();
  }

  Future<void> _carregarEventosInscritos() async {
    try {
      _inscricoes = await InscricoesAPI.getInscricoesPorUser(idUtilizador);
      final idsEventosInscritos = _inscricoes.map((i) => i.idEvento).toList();

      final eventosListas = await Future.wait(
        idsEventosInscritos.map((id) async {
          try {
            return await EventosApi.getEventoPorId(id);
          } catch (_) {
            return null;
          }
        }),
      );

      final eventos = eventosListas.whereType<Evento>().toList();
      final agora = DateTime.now();

      _eventosFuturos = eventos.where((e) => e.dataFim.isAfter(agora)).toList();
      _eventosPassados = eventos.where((e) => e.dataFim.isBefore(agora)).toList();

      setState(() => _loading = false);
    } catch (e) {
      setState(() {
        _erro = e.toString();
        _loading = false;
      });
    }
  }



  Future<void> _desinscrever(BuildContext context, Evento evento) async {
    try {
      final inscricao = _inscricoes.firstWhere(
            (i) => i.idEvento == evento.idEvento,
        orElse: () => throw Exception('Inscrição não encontrada'),
      );

      await InscricoesAPI.eliminarInscricao(inscricao.id_inscricao);
      _inscricoes.remove(inscricao);
      _carregarEventosInscritos();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Inscrição cancelada com sucesso.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao desinscrever: $e')),
      );
    }
  }

  void _abrirDetalhes(BuildContext context, Evento evento) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MenuDetalhesEvento(
          idEvento: evento.idEvento,
          titulo: evento.titulo,
          descricao: evento.descricao,
          preco: evento.preco,
          nomeOrador: evento.nomeOrador,
          dataInicio: evento.dataInicio,
          dataFim: evento.dataFim,
          mediaAvaliacoes: evento.mediaAvaliacoes,
          limiteInscricoes: evento.limiteInscricoes,
          categoria: evento.categoria,
        ),
      ),
    );
  }


  void _avaliarEvento(BuildContext context, Evento evento) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MenuAvaliacao(
          idEvento: evento.idEvento,
          tituloEvento: evento.titulo,
        ),
      ),
    );
  }


  Widget _construirCartao(Evento evento, {required bool podeCancelar}) {
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
                    evento.titulo,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () => podeCancelar
                      ? _desinscrever(context, evento)
                      : _avaliarEvento(context, evento),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: podeCancelar ? Colors.red[700] : verdeEscuro,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(podeCancelar ? 'Cancelar inscrição' : 'Avaliar'),
                ),
              ],
            ),
          ],
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
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _erro != null
          ? Center(child: Text('Erro: $_erro'))
          : (_eventosFuturos.isEmpty && _eventosPassados.isEmpty)
          ? const Center(child: Text('Nenhuma inscrição encontrada.'))
          : ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (_eventosFuturos.isNotEmpty)
            const Text('Eventos Futuros', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ..._eventosFuturos.map((e) => _construirCartao(e, podeCancelar: true)).toList(),
          const SizedBox(height: 20),
          if (_eventosPassados.isNotEmpty)
            const Text('Eventos Passados', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ..._eventosPassados.map((e) => _construirCartao(e, podeCancelar: false)).toList(),
        ],
      ),
    );
  }
}
