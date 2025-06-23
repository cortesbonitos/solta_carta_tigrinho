import 'package:flutter/material.dart';
import 'package:ipca_gestao_eventos/data/inscricoesAPI.dart';
import 'package:ipca_gestao_eventos/models/utilizador.dart';
import 'package:ipca_gestao_eventos/models/pagamento.dart';
import 'package:ipca_gestao_eventos/data/pagamentoAPI.dart';
import 'menu_participante.dart';
import 'package:ipca_gestao_eventos/models/inscricao.dart';
import 'package:ipca_gestao_eventos/models/bilhete.dart';

class MenuPagamentoPaypal extends StatefulWidget {
  final String titulo;
  final double preco;
  final int idEvento;

  const MenuPagamentoPaypal({
    super.key,
    required this.titulo,
    required this.preco,
    required this.idEvento,
  });

  @override
  State<MenuPagamentoPaypal> createState() => _MenuPagamentoPaypalState();
}

class _MenuPagamentoPaypalState extends State<MenuPagamentoPaypal> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  static const Color verdeEscuro = Color(0xFF1a4d3d);
  static const Color verdeClaro = Color(0xFFA8D4BA);

  void _confirmarPagamento() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos.')),
      );
      return;
    }

    final idUtilizador = Utilizador.currentUser!.idUtilizador;
    final dataInscricao = DateTime.now();

    try {
      // 1. Criar inscrição
      await InscricoesAPI.criarInscricao(
        Inscricao(
          id_inscricao: 0,
          idEvento: widget.idEvento,
          idUtilizador: idUtilizador,
          dataInscricao: dataInscricao,
        ),
      );

      // 2. Tentar buscar o bilhete (até 5 vezes, com delay)
      Bilhete? bilhete;
      const maxTentativas = 5;

      for (int tentativa = 0; tentativa < maxTentativas; tentativa++) {
        try {
          final bilhetes = await InscricoesAPI.getBilhetesPorUser(idUtilizador);
          bilhete = bilhetes.firstWhere(
                (b) => b.idEvento == widget.idEvento,
            orElse: () => throw Exception(),
          );
          break;
        } catch (_) {
          await Future.delayed(const Duration(seconds: 1));
        }
      }

      if (bilhete == null || bilhete.idBilhete == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Bilhete não encontrado após várias tentativas.')),
        );
        return;
      }

      // 3. Criar pagamento com o bilhete
      final pagamento = Pagamento(
        dataPagamento: DateTime.now(),
        idBilhete: bilhete.idBilhete!,
        idMetodo: 1, // PayPal
      );

      final sucesso = await PagamentoAPI.criarPagamento(pagamento);

      if (!sucesso) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro ao registar pagamento.')),
        );
        return;
      }

      // 4. Sucesso total
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pagamento e inscrição concluídos com sucesso!')),
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const MenuParticipante()),
            (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagamento via PayPal'),
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
                'Evento: ${widget.titulo}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text('Total: ${widget.preco.toStringAsFixed(2)} €'),
              const SizedBox(height: 24),
              const Text(
                'Simulação de login PayPal',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email PayPal',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Palavra-passe',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _confirmarPagamento,
                style: ElevatedButton.styleFrom(
                  backgroundColor: verdeEscuro,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(48),
                ),
                child: const Text('Confirmar com PayPal'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
