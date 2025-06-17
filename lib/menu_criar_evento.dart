import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'menu_eventos_admin.dart';

class MenuCriarEvento extends StatefulWidget {
  const MenuCriarEvento({super.key});

  @override
  State<MenuCriarEvento> createState() => _MenuCriarEventoState();
}

class _MenuCriarEventoState extends State<MenuCriarEvento> {
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController precoController = TextEditingController();
  final TextEditingController oradorController = TextEditingController();
  final TextEditingController limiteController = TextEditingController();

  DateTime? dataInicio;
  DateTime? dataFim;

  static const Color verdeEscuro = Color(0xFF1a4d3d);
  static const Color verdeClaro = Color(0xFFA8D4BA);

  final String apiUrl = 'https://ipcaeventos-cmh2evayfvghhce9.spaincentral-01.azurewebsites.net/api/evento';

  bool _isLoading = false;

  Future<void> _selecionarDataHora({required bool isInicio}) async {
    final DateTime? data = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );

    if (data == null) return;

    final TimeOfDay? hora = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (hora == null) return;

    final selecionada = DateTime(data.year, data.month, data.day, hora.hour, hora.minute);

    setState(() {
      if (isInicio) {
        dataInicio = selecionada;
      } else {
        dataFim = selecionada;
      }
    });
  }

  String _formataDataSemSegundos(DateTime data) {
    return "${data.year.toString().padLeft(4, '0')}-"
        "${data.month.toString().padLeft(2, '0')}-"
        "${data.day.toString().padLeft(2, '0')}T"
        "${data.hour.toString().padLeft(2, '0')}:"
        "${data.minute.toString().padLeft(2, '0')}";
  }

  Future<void> _criarEvento() async {
    final titulo = tituloController.text.trim();
    final descricao = descricaoController.text.trim();
    final precoTexto = precoController.text.trim();
    final orador = oradorController.text.trim();
    final limiteTexto = limiteController.text.trim();

    final double preco = double.tryParse(precoTexto) ?? 0.0;
    final int? limiteInscricoes = limiteTexto.isEmpty ? null : int.tryParse(limiteTexto);

    if (titulo.isEmpty || descricao.isEmpty || orador.isEmpty || dataInicio == null || dataFim == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preenche todos os campos obrigatórios.')),
      );
      return;
    }

    setState(() => _isLoading = true);

    final Map<String, dynamic> eventoData = {
      "titulo": titulo,
      "descricao": descricao,
      "data_inicio": _formataDataSemSegundos(dataInicio!),
      "data_fim": _formataDataSemSegundos(dataFim!),
      "media_avaliacoes": 5.0,
      "limite_inscricoes": limiteInscricoes,
      "id_categoria": 2,
      "nome_orador": orador,
      "preco": preco,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(eventoData),
      );

      setState(() => _isLoading = false);

      if (response.statusCode == 201 || response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Evento criado com sucesso!')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MenuEventosAdmin()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao criar evento: ${response.statusCode}')),
        );
      }
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro de ligação ao servidor.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Evento'),
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
          child: SingleChildScrollView(
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
                const Text('Orador'),
                const SizedBox(height: 8),
                TextField(
                  controller: oradorController,
                  decoration: _inputDecoration(),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => _selecionarDataHora(isInicio: true),
                  child: Text(dataInicio == null
                      ? 'Selecionar Data de Início'
                      : 'Início: ${dataInicio!.day}/${dataInicio!.month} ${dataInicio!.hour}:${dataInicio!.minute.toString().padLeft(2, '0')}'),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => _selecionarDataHora(isInicio: false),
                  child: Text(dataFim == null
                      ? 'Selecionar Data de Fim'
                      : 'Fim: ${dataFim!.day}/${dataFim!.month} ${dataFim!.hour}:${dataFim!.minute.toString().padLeft(2, '0')}'),
                ),
                const SizedBox(height: 16),
                const Text('Preço (€)'),
                const SizedBox(height: 8),
                TextField(
                  controller: precoController,
                  keyboardType: TextInputType.number,
                  decoration: _inputDecoration().copyWith(hintText: '0 para evento grátis'),
                ),
                const SizedBox(height: 16),
                const Text('Limite de Inscrições (opcional)'),
                const SizedBox(height: 8),
                TextField(
                  controller: limiteController,
                  keyboardType: TextInputType.number,
                  decoration: _inputDecoration().copyWith(hintText: 'Deixe em branco para sem limite'),
                ),
                const SizedBox(height: 24),
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                  onPressed: _criarEvento,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: verdeEscuro,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('Criar Evento'),
                ),
              ],
            ),
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
