import 'package:flutter/material.dart';
import 'package:ipca_gestao_eventos/models/utilizador.dart';
import 'package:ipca_gestao_eventos/data/eventosAPI.dart';
import 'data/inscricoesAPI.dart';
import 'menu_pagamento_metodos.dart';
import 'menu_logout.dart';
import 'models/inscricao.dart';

class MenuDetalhesEvento extends StatelessWidget {
  final String titulo;
  final String descricao;
  final double preco;
  final String nomeOrador;
  final DateTime dataInicio;
  final DateTime dataFim;
  final double mediaAvaliacoes;
  final int? limiteInscricoes;
  final int idEvento;

  const MenuDetalhesEvento({
    super.key,
    required this.titulo,
    required this.descricao,
    required this.preco,
    required this.nomeOrador,
    required this.dataInicio,
    required this.dataFim,
    required this.mediaAvaliacoes,
    required this.limiteInscricoes,
    required this.idEvento,
  });

  static const Color verdeEscuro = Color(0xFF1a4d3d);
  static const Color verdeClaro = Color(0xFFA8D4BA);

  void _inscreverOuPagar(BuildContext context) async {
    final idUtilizador = Utilizador.currentUser?.idUtilizador;

    if (idUtilizador == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro: Utilizador não autenticado.')),
      );
      return;
    }

    if (preco > 0) {
      // Evento pago
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Evento Pago'),
          content: Text('Custa ${preco.toStringAsFixed(2)} €. Deseja avançar com o pagamento?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Fechar o diálogo
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MenuPagamentoMetodos(
                      titulo: titulo,
                      preco: preco,
                    ),
                  ),
                );
              },
              child: const Text('Sim'),
            ),
          ],
        ),
      );
    } else {
      // Evento grátis — fazer inscrição real
      try {
        Inscricao novaInscricao = Inscricao(
          idInscricao: 0,
          idEvento: idEvento,
          idUtilizador: idUtilizador,
          dataInscricao: DateTime.now(),
        );
        print(novaInscricao);
        await InscricoesAPI.criarInscricao(novaInscricao);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Inscrição feita com sucesso!')),
        );

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const MenuLogout()),
              (route) => false,
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao inscrever: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final String dataFormatada =
        '${dataInicio.day}/${dataInicio.month}/${dataInicio.year} ${dataInicio.hour}:${dataInicio.minute.toString().padLeft(2, '0')} - '
        '${dataFim.hour}:${dataFim.minute.toString().padLeft(2, '0')}';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Evento'),
        backgroundColor: verdeEscuro,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: 340,
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
              Text(descricao),
              const SizedBox(height: 12),
              Text('Orador: $nomeOrador'),
              const SizedBox(height: 8),
              Text('Data: $dataFormatada'),
              const SizedBox(height: 8),
              Text('Média de avaliações: ${mediaAvaliacoes.toStringAsFixed(1)} ⭐'),
              const SizedBox(height: 8),
              Text(limiteInscricoes != null
                  ? 'Limite de inscrições: $limiteInscricoes'
                  : 'Sem limite de inscrições'),
              const SizedBox(height: 12),
              Text(
                preco == 0 ? 'Evento Grátis' : 'Preço: ${preco.toStringAsFixed(2)} €',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => _inscreverOuPagar(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: verdeEscuro,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('Inscrever-se'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
