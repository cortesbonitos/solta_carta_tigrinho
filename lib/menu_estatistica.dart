import 'package:flutter/material.dart';
import 'package:ipca_gestao_eventos/data/eventosAPI.dart';
import 'package:ipca_gestao_eventos/data/inscricoesAPI.dart';
import 'package:ipca_gestao_eventos/data/utilizadorAPI.dart';
import 'package:ipca_gestao_eventos/models/utilizador.dart';

class MenuEstatistica extends StatefulWidget {
  const MenuEstatistica({super.key});

  @override
  State<MenuEstatistica> createState() => _MenuEstatisticaState();
}

class _MenuEstatisticaState extends State<MenuEstatistica> {
  static const Color verdeEscuro = Color(0xFF1a4d3d);
  static const Color verdeClaro = Color(0xFFA8D4BA);

  int totalEventos = 0;
  int totalUtilizadores = 0;
  int totalInscricoes = 0;
  int eventosPagos = 0;
  int eventosGratis = 0;
  bool carregando = true;
  String? erro;

  double get mediaInscricoes => totalEventos == 0 ? 0 : totalInscricoes / totalEventos;

  @override
  void initState() {
    super.initState();
    _carregarEstatisticas();
  }

  Future<void> _carregarEstatisticas() async {
    try {
      // Carregar eventos
      final eventos = await EventosApi.getEventos();
      totalEventos = eventos.length;
      eventosPagos = eventos.where((e) => e.preco > 0).length;
      eventosGratis = totalEventos - eventosPagos;

      // Carregar utilizadores (tipo 1 = participante)
      await UtilizadorAPI.carregarTodos();
      totalUtilizadores = Utilizador.utilizadores.values
          .where((u) => u.idTipoUtilizador == 1)
          .length;

      // Calcular total de inscrições em todos os eventos
      int total = 0;
      for (var e in eventos) {
        final inscricoes = await InscricoesAPI.getInscricoesPorEvento(e.idEvento);
        total += inscricoes.length;
      }
      totalInscricoes = total;

      setState(() => carregando = false);
    } catch (e) {
      setState(() {
        erro = e.toString();
        carregando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Estatísticas'),
        backgroundColor: verdeEscuro,
      ),
      body: carregando
          ? const Center(child: CircularProgressIndicator())
          : erro != null
          ? Center(child: Text('Erro: $erro'))
          : Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: [
            _buildBox('Total de Eventos', '$totalEventos', Icons.event),
            _buildBox('Total de Utilizadores', '$totalUtilizadores', Icons.people),
            _buildBox('Total de Inscrições', '$totalInscricoes', Icons.assignment_turned_in),
            _buildBox('Média de Inscrições por Evento', mediaInscricoes.toStringAsFixed(2), Icons.bar_chart),
            _buildBox('Eventos Pagos', '$eventosPagos', Icons.attach_money),
            _buildBox('Eventos Grátis', '$eventosGratis', Icons.money_off),
          ],
        ),
      ),
    );
  }

  Widget _buildBox(String titulo, String valor, IconData icone) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: verdeClaro,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icone, size: 32, color: verdeEscuro),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              titulo,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            valor,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
