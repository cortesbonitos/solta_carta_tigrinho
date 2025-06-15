import 'package:flutter/material.dart';
import 'package:ipca_gestao_eventos/data/eventosAPI.dart';
import 'package:ipca_gestao_eventos/data/inscricoesAPI.dart';
import 'package:ipca_gestao_eventos/models/eventos.dart';
import 'package:ipca_gestao_eventos/models/inscricao.dart';
import 'package:ipca_gestao_eventos/models/utilizador.dart';
import 'menu_participante.dart';
import 'menu_detalhes_meu_evento.dart';

class MenuListaMeusEventos extends StatefulWidget {
  const MenuListaMeusEventos({super.key});

  @override
  State<MenuListaMeusEventos> createState() => _MenuListaMeusEventosState();
}

class _MenuListaMeusEventosState extends State<MenuListaMeusEventos> {
  static const Color verdeEscuro = Color(0xFF1a4d3d);
  static const Color verdeClaro = Color(0xFFA8D4BA);
  final idUtilizador = Utilizador.currentUser!.idUtilizador;

  List<Evento> _eventosInscritos = [];
  bool _loading = true;
  String? _erro;

  @override
  void initState() {
    super.initState();
    _carregarEventosInscritos();
  }

  Future<void> _carregarEventosInscritos() async {
    try {

      final inscricoes = await InscricoesAPI.getInscricoesPorUser(idUtilizador);
      final idsEventosInscritos = inscricoes.map((i) => i.idEvento).toList();
      final eventosListas = await Future.wait(
        idsEventosInscritos.map((id) => EventosApi.getEventosPorId(id)),
      );

       _eventosInscritos = eventosListas.expand((e) => e).toList();


      setState(() {
        //_eventosInscritos = apenasMeusEventos;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _erro = e.toString();
        _loading = false;
      });
    }
  }

  Future<void> _desinscrever(BuildContext context, Evento evento) async {
    try {
      InscricoesAPI.eliminarInscricao(evento.idEvento);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Inscrição cancelada com sucesso.')),
      );

      _carregarEventosInscritos(); // Atualizar a lista
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao desinscrever: $e')),
      );
    }
  }

  void _abrirDetalhes(BuildContext context, Evento evento) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MenuDetalhesMeuEvento(
          titulo: evento.titulo,
          descricao: evento.descricao,
          preco: evento.preco,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Meus Eventos'),
        backgroundColor: verdeEscuro,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _erro != null
          ? Center(child: Text('Erro: $_erro'))
          : _eventosInscritos.isEmpty
          ? const Center(child: Text('Nenhuma inscrição encontrada.'))
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _eventosInscritos.length,
        itemBuilder: (context, index) {
          final evento = _eventosInscritos[index];

          return GestureDetector(
            onTap: () => _abrirDetalhes(context, evento),
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: verdeClaro,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.event_available),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          evento.titulo,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(evento.descricao),
                  const SizedBox(height: 8),
                  Text(
                    evento.preco == 0
                        ? 'Grátis'
                        : 'Preço: ${evento.preco.toStringAsFixed(2)} €',
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () => _desinscrever(context, evento),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[700],
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Cancelar inscrição'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
