import 'package:flutter/material.dart';
import 'menu_eventos_admin.dart';

class MenuEditarEvento extends StatefulWidget {
  const MenuEditarEvento({super.key});

  @override
  State<MenuEditarEvento> createState() => _MenuEditarEventoState();
}

class _MenuEditarEventoState extends State<MenuEditarEvento> {
  final TextEditingController tituloController = TextEditingController(text: 'Evento Exemplo');
  final TextEditingController descricaoController = TextEditingController(text: 'Descrição do evento');
  final TextEditingController precoController = TextEditingController(text: '10.0');

  static const Color verdeEscuro = Color(0xFF1a4d3d);
  static const Color verdeClaro = Color(0xFFA8D4BA);

  void _guardarAlteracoes() {
    final titulo = tituloController.text.trim();
    final descricao = descricaoController.text.trim();
    final precoTexto = precoController.text.trim();

    double preco = double.tryParse(precoTexto) ?? 0.0;

    // Aqui poderias enviar os dados atualizados para a API ou base de dados

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Evento atualizado com sucesso!')),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) =>  MenuEventosAdmin()),
    );
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
