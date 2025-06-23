import 'package:flutter/material.dart';

class MenuDetalhesMeuEvento extends StatelessWidget {
  final String titulo;
  final String descricao;
  final double preco;
  final String nomeOrador;
  final String dataInicio;
  final String dataFim;
  final String local;
  final String categoria;
  final int? limiteInscricoes;
  final double mediaAvaliacoes;

  const MenuDetalhesMeuEvento({
    super.key,
    required this.titulo,
    required this.descricao,
    required this.preco,
    required this.nomeOrador,
    required this.dataInicio,
    required this.dataFim,
    required this.local,
    required this.categoria,
    required this.limiteInscricoes,
    required this.mediaAvaliacoes,

  });

  static const Color verdeEscuro = Color(0xFF1a4d3d);
  static const Color verdeClaro = Color(0xFFA8D4BA);

  @override
  Widget build(BuildContext context) {
    final localFinal = local.isEmpty ? 'Sem Localização' : local;
    final categoriaFinal = categoria.isEmpty ? 'Sem Categoria' : categoria;

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
              const SizedBox(height: 12),
              Text('Categoria: $categoriaFinal'),
              const SizedBox(height: 8),
              Text('Descrição: $descricao'),
              const SizedBox(height: 8),
              Text('Orador: $nomeOrador'),
              Text('Início: $dataInicio'),
              Text('Fim: $dataFim'),
              Text('Localização: $localFinal'),
              Text('Média avaliações: ${mediaAvaliacoes.toStringAsFixed(1)}'),
              Text('Limite Inscrições: ${limiteInscricoes ?? 'Ilimitado'}'),
              const SizedBox(height: 12),
              Text(
                preco == 0 ? 'Evento Grátis' : 'Preço: ${preco.toStringAsFixed(2)} €',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[700],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('Voltar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
