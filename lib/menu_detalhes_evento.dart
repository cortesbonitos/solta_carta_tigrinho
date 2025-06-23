import 'package:flutter/material.dart';
import 'package:ipca_gestao_eventos/data/inscricoesAPI.dart';
import 'package:ipca_gestao_eventos/data/filaEsperaAPI.dart';
import 'package:ipca_gestao_eventos/models/inscricao.dart';
import 'package:ipca_gestao_eventos/models/filaEspera.dart';
import 'package:ipca_gestao_eventos/models/utilizador.dart';
import 'menu_pagamento_metodos.dart';

class MenuDetalhesEvento extends StatelessWidget {
  final int idEvento;
  final String titulo;
  final String descricao;
  final double preco;
  final String nomeOrador;
  final DateTime dataInicio;
  final DateTime dataFim;
  final double mediaAvaliacoes;
  final int? limiteInscricoes;
  final String categoria;
  final String localizacao;
  final bool jaInscrito;

  const MenuDetalhesEvento({
    super.key,
    required this.idEvento,
    required this.titulo,
    required this.descricao,
    required this.preco,
    required this.nomeOrador,
    required this.dataInicio,
    required this.dataFim,
    required this.mediaAvaliacoes,
    required this.limiteInscricoes,
    required this.categoria,
    required this.localizacao,
    this.jaInscrito = false,
  });

  static const Color verdeClaro = Color(0xFFA8D4BA);
  static const Color verdeEscuro = Color(0xFF1a4d3d);

  Future<void> _inscreverOuFila(BuildContext context) async {
    final idUtilizador = Utilizador.currentUser!.idUtilizador;
    final dataInscricao = DateTime.now();

    try {
      final inscricoes = await InscricoesAPI.getInscricoesPorEvento(idEvento);
      final numInscritos = inscricoes.length;
      final limite = limiteInscricoes ?? -1;

      if (limite > 0 && numInscritos >= limite) {
        await FilaEsperaAPI.criarEntradaFila(
          FilaEspera(
            dataEntrada: DateTime.now(),
            idUtilizador: idUtilizador,
            idEvento: idEvento,
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Evento cheio! Entraste na fila de espera.")),
        );
        Navigator.pop(context);
        return;
      }

      if (preco > 0) {
        final confirmar = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Confirmação"),
            content: Text("Custa ${preco.toStringAsFixed(2)} €, deseja avançar com o pagamento?"),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text("Cancelar")),
              ElevatedButton(onPressed: () => Navigator.pop(ctx, true), child: const Text("Avançar")),
            ],
          ),
        );

        if (confirmar != true) return;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MenuPagamentoMetodos(
              titulo: titulo,
              preco: preco,
              idEvento: idEvento,
            ),
          ),
        );
      } else {
        await InscricoesAPI.criarInscricao(
          Inscricao(
            id_inscricao: 0,
            idEvento: idEvento,
            idUtilizador: idUtilizador,
            dataInscricao: dataInscricao,
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Inscrição feita com sucesso.")),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool eventoExpirado = DateTime.now().isAfter(dataFim);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalhes do Evento"),
        backgroundColor: verdeEscuro,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: 320,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: verdeClaro,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titulo,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text("Categoria: $categoria"),
              const SizedBox(height: 6),
              Text("Descrição: $descricao"),
              const SizedBox(height: 6),
              Text("Orador: $nomeOrador"),
              Text("Início: ${dataInicio.toLocal()}".substring(0, 16)),
              Text("Fim: ${dataFim.toLocal()}".substring(0, 16)),
              Text("Localização: $localizacao"),
              Text("Média avaliações: ${mediaAvaliacoes.toStringAsFixed(1)}"),
              Text("Limite inscrições: ${limiteInscricoes ?? 'Ilimitado'}"),
              const SizedBox(height: 8),
              Text(
                preco == 0 ? 'Evento Grátis' : 'Preço: ${preco.toStringAsFixed(2)} €',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 20),
              if (!eventoExpirado && !jaInscrito)
                ElevatedButton(
                  onPressed: () => _inscreverOuFila(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: verdeEscuro,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(preco == 0 ? 'Inscrever-se' : 'Avançar para Pagamento'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
