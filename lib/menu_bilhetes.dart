import 'package:flutter/material.dart';
import 'package:ipca_gestao_eventos/data/eventosAPI.dart';
import 'package:ipca_gestao_eventos/data/inscricoesAPI.dart';
import 'package:ipca_gestao_eventos/models/utilizador.dart';
import 'menu_bilhete_detalhes.dart';

class MenuBilhetes extends StatefulWidget {
  const MenuBilhetes({super.key});

  @override
  State<MenuBilhetes> createState() => _MenuBilhetesState();
}

class _MenuBilhetesState extends State<MenuBilhetes> {
  List<Map<String, String>> bilhetesAtivos = [];
  List<Map<String, String>> bilhetesExpirados = [];
  bool _isLoading = true;
  String? _erro;

  static const Color verdeEscuro = Color(0xFF1a4d3d);
  static const Color verdeClaro = Color(0xFFA8D4BA);

  @override
  void initState() {
    super.initState();
    _carregarBilhetes();
  }

  Future<void> _carregarBilhetes() async {
    try {
      final inscricoes = await InscricoesAPI.getInscricoesPorUser(Utilizador.currentUser!.idUtilizador);
      final agora = DateTime.now();

      for (var i in inscricoes) {
        final evento = await EventosApi.getEventoPorId(i.idEvento);
        if (evento != null) {
          final dataInicioStr = evento.dataInicio.toString().substring(0, 10);
          final map = {
            'titulo': evento.titulo,
            'data': dataInicioStr,
          };

          if (evento.dataFim.isAfter(agora)) {
            bilhetesAtivos.add(map);
          } else {
            bilhetesExpirados.add(map);
          }
        }
      }

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _erro = e.toString();
        _isLoading = false;
      });
    }
  }

  Widget construirSecao(String titulo, List<Map<String, String>> bilhetes, String estado) {
    if (bilhetes.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...bilhetes.map((bilhete) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MenuBilheteDetalhes(
                    titulo: bilhete['titulo']!,
                    data: bilhete['data']!,
                    estado: estado,
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: verdeClaro,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bilhete['titulo']!,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text('Data: ${bilhete['data']}'),
                  Text('Estado: $estado'),
                ],
              ),
            ),
          );
        }),
        const SizedBox(height: 24),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Bilhetes'),
        backgroundColor: verdeEscuro,
      ),
      backgroundColor: Colors.white,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _erro != null
          ? Center(child: Text('Erro: $_erro'))
          : Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            construirSecao('Bilhetes Ativos', bilhetesAtivos, 'Ativo'),
            construirSecao('Bilhetes Expirados', bilhetesExpirados, 'Expirado'),
          ],
        ),
      ),
    );
  }
}
