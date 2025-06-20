import 'package:flutter/material.dart';
import 'package:ipca_gestao_eventos/data/eventosAPI.dart';
import 'package:ipca_gestao_eventos/data/inscricoesAPI.dart';
import 'package:ipca_gestao_eventos/models/inscricao.dart';
import 'package:ipca_gestao_eventos/models/utilizador.dart';
import 'menu_pagamento_metodos.dart';
import 'menu_logout.dart';

class MenuDetalhesEvento extends StatelessWidget {
  final String titulo;
  final String descricao;
  final double preco;
  final String nomeOrador;
  final DateTime dataInicio;
  final DateTime dataFim;
  final double? mediaAvaliacoes;
  final int? limiteInscricoes;
  final int idEvento;
  final String categoria;
  final String localizacao; // <--- ADICIONADO

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
    required this.categoria,
    required this.localizacao, // <--- ADICIONADO
  });

  static const Color verdeEscuro = Color(0xFF1a4d3d);
  static const Color verdeClaro = Color(0xFFA8D4BA);

  @override
  Widget build(BuildContext context) {
    final idUtilizador = Utilizador.currentUser!.idUtilizador;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Evento'),
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
              const SizedBox(height: 8),
              Text('Categoria: $categoria', style: const TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(height: 12),
              Text('Descrição: $descricao', style: const TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(height: 12),
              Text('Orador: $nomeOrador'),
              Text('Início: ${dataInicio.toString().substring(0, 16)}'),
              Text('Fim: ${dataFim.toString().substring(0, 16)}'),
              Text('Localização: $localizacao'), // <--- ADICIONADO
              Text('Média avaliações: ${mediaAvaliacoes?.toStringAsFixed(1) ?? 'N/A'}'),
              Text('Limite inscrições: ${limiteInscricoes?.toString() ?? 'Ilimitado'}'),
              const SizedBox(height: 12),
              Text(
                preco == 0 ? 'Evento Grátis' : 'Preço: ${preco.toStringAsFixed(2)} €',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  if (preco > 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MenuPagamentoMetodos(
                          titulo: titulo,
                          preco: preco,
                        ),
                      ),
                    );
                  } else {
                    try {
                      Inscricao novaInscricao = Inscricao(
                        id_inscricao: 0,
                        idEvento: idEvento,
                        idUtilizador: idUtilizador,
                        dataInscricao: DateTime.now(),
                      );
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
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: verdeEscuro,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(preco > 0 ? 'Avançar para Pagamento' : 'Inscrever-se'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
