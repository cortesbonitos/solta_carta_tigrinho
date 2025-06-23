import 'package:flutter/material.dart';
import 'package:ipca_gestao_eventos/data/eventosAPI.dart';
import 'menu_eventos_admin.dart';

class MenuDetalhesEventoAdmin extends StatelessWidget {
  final int idEvento;
  final String titulo;
  final String descricao;
  final double preco;
  final String dataInicio;
  final String dataFim;
  final double? mediaAvaliacoes;
  final int? limiteInscricoes;
  final String categoria;
  final String nomeOrador;
  final String local;

  const MenuDetalhesEventoAdmin({
    super.key,
    required this.idEvento,
    required this.titulo,
    required this.descricao,
    required this.preco,
    required this.dataInicio,
    required this.dataFim,
    required this.mediaAvaliacoes,
    required this.limiteInscricoes,
    required this.categoria,
    required this.nomeOrador,
    required this.local,
  });

  static const Color verdeEscuro = Color(0xFF1a4d3d);
  static const Color verdeClaro = Color(0xFFA8D4BA);

  void _eliminarEvento(BuildContext context) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Eliminar Evento'),
        content: const Text('Tem a certeza que deseja eliminar este evento?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirmar == true) {
      try {
        await EventosApi.eliminarEvento(idEvento);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Evento eliminado com sucesso')),
        );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const MenuEventosAdmin()),
              (route) => false,
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao eliminar evento: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoriaFinal = categoria.trim().isEmpty ? 'Sem Categoria' : categoria;
    final localFinal = local.trim().isEmpty ? 'Sem Localização' : local;

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
              const SizedBox(height: 8),
              Text(preco == 0
                  ? 'Evento Grátis'
                  : 'Preço: ${preco.toStringAsFixed(2)} €'),
              const SizedBox(height: 8),
              Text('Início: $dataInicio'),
              Text('Fim: $dataFim'),
              const SizedBox(height: 8),
              Text('Orador: $nomeOrador'),
              Text('Categoria: $categoriaFinal'),
              Text('Localização: $localFinal'),
              Text('Limite de Inscrições: ${limiteInscricoes ?? 'Ilimitado'}'),
              Text('Média Avaliações: ${mediaAvaliacoes?.toStringAsFixed(1) ?? 'Sem avaliações'}'),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () => _eliminarEvento(context),
                icon: const Icon(Icons.delete),
                label: const Text('Eliminar Evento'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
