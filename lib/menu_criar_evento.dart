import 'package:flutter/material.dart';
import 'package:ipca_gestao_eventos/models/eventos.dart';
import 'package:ipca_gestao_eventos/data/eventosAPI.dart';

class MenuCriarEvento extends StatefulWidget {
  const MenuCriarEvento({super.key});

  @override
  State<MenuCriarEvento> createState() => _MenuCriarEventoState();
}

class _MenuCriarEventoState extends State<MenuCriarEvento> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _precoController = TextEditingController();
  final TextEditingController _nomeOradorController = TextEditingController();
  final TextEditingController _limiteInscricoesController = TextEditingController();
  final TextEditingController _categoriaController = TextEditingController();
  final TextEditingController _localController = TextEditingController();

  DateTime? _dataInicio;
  DateTime? _dataFim;

  static const Color verdeEscuro = Color(0xFF1a4d3d);
  static const Color verdeClaro = Color(0xFFA8D4BA);

  Future<void> _selecionarDataHora(BuildContext context, bool inicio) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );

    if (pickedDate == null) return;

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime == null) return;

    final fullDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    setState(() {
      if (inicio) {
        _dataInicio = fullDateTime;
      } else {
        _dataFim = fullDateTime;
      }
    });
  }

  void _criarEvento() async {
    if (_tituloController.text.isEmpty ||
        _descricaoController.text.isEmpty ||
        _nomeOradorController.text.isEmpty ||
        _categoriaController.text.isEmpty ||
        _localController.text.isEmpty ||
        _dataInicio == null ||
        _dataFim == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos obrigatórios!')),
      );
      return;
    }

    final novoEvento = Evento(
      idEvento: 0,
      titulo: _tituloController.text,
      descricao: _descricaoController.text,
      preco: double.tryParse(_precoController.text) ?? 0.0,
      dataInicio: _dataInicio!,
      dataFim: _dataFim!,
      mediaAvaliacoes: 0,
      limiteInscricoes: int.tryParse(_limiteInscricoesController.text),
      nomeOrador: _nomeOradorController.text,
      categoria: _categoriaController.text,
      localizacao: _localController.text,
    );

    try {
      await EventosApi.criarEvento(novoEvento);
      Navigator.pop(context);
    } catch (e) {
      print('Erro ao criar evento: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao criar evento')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Criar Evento"),
        backgroundColor: verdeEscuro,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: _tituloController,
              decoration: const InputDecoration(labelText: 'Título *'),
            ),
            TextField(
              controller: _descricaoController,
              decoration: const InputDecoration(labelText: 'Descrição *'),
            ),
            TextField(
              controller: _precoController,
              decoration: const InputDecoration(labelText: 'Preço'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _nomeOradorController,
              decoration: const InputDecoration(labelText: 'Nome do Orador *'),
            ),
            TextField(
              controller: _limiteInscricoesController,
              decoration: const InputDecoration(labelText: 'Limite de Inscrições'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _categoriaController,
              decoration: const InputDecoration(labelText: 'Categoria *'),
            ),
            TextField(
              controller: _localController,
              decoration: const InputDecoration(labelText: 'Localização *'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _selecionarDataHora(context, true),
              child: Text(_dataInicio == null
                  ? 'Selecionar Data e Hora de Início *'
                  : 'Início: ${_dataInicio!.toString()}'),
            ),
            ElevatedButton(
              onPressed: () => _selecionarDataHora(context, false),
              child: Text(_dataFim == null
                  ? 'Selecionar Data e Hora de Fim *'
                  : 'Fim: ${_dataFim!.toString()}'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _criarEvento,
              style: ElevatedButton.styleFrom(
                backgroundColor: verdeEscuro,
                foregroundColor: Colors.white,
              ),
              child: const Text('Criar Evento'),
            )
          ],
        ),
      ),
    );
  }
}
