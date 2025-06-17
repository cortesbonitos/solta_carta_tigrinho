import 'package:flutter/material.dart';
import 'package:ipca_gestao_eventos/data/avaliacoesAPI.dart';
import 'package:ipca_gestao_eventos/models/utilizador.dart';
import 'menu_participante.dart';

class MenuAvaliacao extends StatefulWidget {
  final int idEvento;
  final String tituloEvento;

  const MenuAvaliacao({
    super.key,
    required this.idEvento,
    required this.tituloEvento,
  });

  @override
  State<MenuAvaliacao> createState() => _MenuAvaliacaoState();
}

class _MenuAvaliacaoState extends State<MenuAvaliacao> {
  int _rating = 0;
  final TextEditingController _comentarioController = TextEditingController();

  static const Color verdeEscuro = Color(0xFF1a4d3d);
  static const Color verdeClaro = Color(0xFFA8D4BA);

  void _enviarAvaliacao() async {
    if (_rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, selecione uma nota.')),
      );
      return;
    }

    final idUtilizador = Utilizador.currentUser!.idUtilizador;

    final sucesso = await AvaliacoesAPI.enviarAvaliacao(
      idEvento: widget.idEvento,
      idUtilizador: idUtilizador,
      nota: _rating,
      comentario: _comentarioController.text.trim(),
    );

    if (sucesso) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Avaliação enviada com sucesso!')),
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const MenuParticipante()),
            (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao enviar avaliação.')),
      );
    }
  }

  Widget _construirEstrelas() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        final estrela = index + 1;
        return IconButton(
          icon: Icon(
            estrela <= _rating ? Icons.star : Icons.star_border,
            color: Colors.amber,
          ),
          onPressed: () {
            setState(() {
              _rating = estrela;
            });
          },
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Avaliar Evento'),
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
            children: [
              Text(
                widget.tituloEvento,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              const Text('Avaliação:'),
              _construirEstrelas(),
              const SizedBox(height: 16),
              const Text('Comentário (opcional):'),
              const SizedBox(height: 8),
              TextField(
                controller: _comentarioController,
                maxLines: 3,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _enviarAvaliacao,
                style: ElevatedButton.styleFrom(
                  backgroundColor: verdeEscuro,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('Enviar Avaliação'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
