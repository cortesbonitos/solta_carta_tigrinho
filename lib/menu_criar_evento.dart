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

  DateTime? _dataInicio;
  TimeOfDay? _horaInicio;
  DateTime? _dataFim;
  TimeOfDay? _horaFim;

  static const Color verdeEscuro = Color(0xFF1a4d3d);
  static const Color verdeClaro = Color(0xFFA8D4BA);

  Future<void> _selecionarDataHora(BuildContext context, bool inicio) async {
    final data = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );

    if (data != null) {
      final hora = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (hora != null) {
        setState(() {
          if (inicio) {
            _dataInicio = data;
            _horaInicio = hora;
          } else {
            _dataFim = data;
            _horaFim = hora;
          }
        });
      }
    }
  }

  void _criarEvento() async {
    if (_dataInicio == null || _dataFim == null || _horaInicio == null || _horaFim == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor selecione data e hora de início e fim')),
      );
      return;
    }

    final dataHoraInicio = DateTime(
      _dataInicio!.year,
      _dataInicio!.month,
      _dataInicio!.day,
      _horaInicio!.hour,
      _horaInicio!.minute,
    );

    final dataHoraFim = DateTime(
      _dataFim!.year,
      _dataFim!.month,
      _dataFim!.day,
      _horaFim!.hour,
      _horaFim!.minute,
    );

    final novoEvento = Evento(
      idEvento: 0,
      titulo: _tituloController.text,
      descricao: _descricaoController.text,
      preco: double.tryParse(_precoController.text) ?? 0.0,
      dataInicio: dataHoraInicio,
      dataFim: dataHoraFim,
      mediaAvaliacoes: 0,
      limiteInscricoes: int.tryParse(_limiteInscricoesController.text),
      nomeOrador: _nomeOradorController.text,
      categoria: _categoriaController.text,
    );

    try {
      await EventosApi.criarEvento(novoEvento);
      Navigator.pop(context);
    } catch (e) {
      print('Erro ao criar evento: $e');
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
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _descricaoController,
              decoration: const InputDecoration(labelText: 'Descrição'),
            ),
            TextField(
              controller: _precoController,
              decoration: const InputDecoration(labelText: 'Preço'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _nomeOradorController,
              decoration: const InputDecoration(labelText: 'Nome do Orador'),
            ),
            TextField(
              controller: _limiteInscricoesController,
              decoration: const InputDecoration(labelText: 'Limite de Inscrições'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _categoriaController,
              decoration: const InputDecoration(labelText: 'Categoria'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _selecionarDataHora(context, true),
              child: Text(
                _dataInicio == null || _horaInicio == null
                    ? 'Selecionar Data/Hora Início'
                    : 'Início: ${_dataInicio!.toLocal().toString().split(' ')[0]} ${_horaInicio!.format(context)}',
              ),
            ),
            ElevatedButton(
              onPressed: () => _selecionarDataHora(context, false),
              child: Text(
                _dataFim == null || _horaFim == null
                    ? 'Selecionar Data/Hora Fim'
                    : 'Fim: ${_dataFim!.toLocal().toString().split(' ')[0]} ${_horaFim!.format(context)}',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _criarEvento,
              style: ElevatedButton.styleFrom(backgroundColor: verdeEscuro, foregroundColor: Colors.white),
              child: const Text('Criar Evento'),
            )
          ],
        ),
      ),
    );
  }
}
