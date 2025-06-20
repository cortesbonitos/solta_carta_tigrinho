import 'package:flutter/material.dart';
import 'menu_eventos_admin.dart';
import 'package:ipca_gestao_eventos/models/eventos.dart';
import 'package:ipca_gestao_eventos/data/eventosAPI.dart';

class MenuEditarEvento extends StatefulWidget {
  final int idEvento;
  final String titulo;
  final String descricao;
  final double preco;

  const MenuEditarEvento({
    super.key,
    required this.idEvento,
    required this.titulo,
    required this.descricao,
    required this.preco,
  });

  @override
  State<MenuEditarEvento> createState() => _MenuEditarEventoState();
}

class _MenuEditarEventoState extends State<MenuEditarEvento> {
  late TextEditingController tituloController;
  late TextEditingController descricaoController;
  late TextEditingController precoController;

  static const Color verdeEscuro = Color(0xFF1a4d3d);
  static const Color verdeClaro = Color(0xFFA8D4BA);

  @override
  void initState() {
    super.initState();
    tituloController = TextEditingController(text: widget.titulo);
    descricaoController = TextEditingController(text: widget.descricao);
    precoController = TextEditingController(text: widget.preco.toStringAsFixed(2));
  }

  void _guardarAlteracoes() async {
    final titulo = tituloController.text.trim();
    final descricao = descricaoController.text.trim();
    final precoTexto = precoController.text.trim();

    // Validação
    if (precoTexto.isEmpty || double.tryParse(precoTexto) == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Insere um preço válido.')),
      );
      return;
    }

    final double preco = double.parse(precoTexto);

    print('Preço enviado: $preco');

    final eventoAtualizado = Evento(
      idEvento: widget.idEvento,
      titulo: titulo,
      descricao: descricao,
      dataInicio: DateTime(2025, 6, 25, 10, 0),
      dataFim: DateTime(2025, 6, 25, 12, 0),
      mediaAvaliacoes: 5.0,
      limiteInscricoes: null,
      categoria: "Tecnologia",
      nomeOrador: "Prof. Ana Marques",
      preco: preco, localizacao: '',
    );

    try {
      await EventosApi.atualizarEvento(eventoAtualizado);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Evento atualizado com sucesso!')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MenuEventosAdmin()),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao atualizar evento: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Evento'),
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
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Título do Evento'),
              const SizedBox(height: 8),
              TextField(
                controller: tituloController,
                decoration: _inputDecoration(),
              ),
              const SizedBox(height: 16),
              const Text('Descrição'),
              const SizedBox(height: 8),
              TextField(
                controller: descricaoController,
                maxLines: 3,
                decoration: _inputDecoration(),
              ),
              const SizedBox(height: 16),
              const Text('Preço (€)'),
              const SizedBox(height: 8),
              TextField(
                controller: precoController,
                keyboardType: TextInputType.number,
                decoration: _inputDecoration().copyWith(hintText: '0 para evento grátis'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _guardarAlteracoes,
                style: ElevatedButton.styleFrom(
                  backgroundColor: verdeEscuro,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('Guardar Alterações'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
