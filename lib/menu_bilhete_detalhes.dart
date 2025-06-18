import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MenuBilheteDetalhes extends StatelessWidget {
  final String titulo;
  final String data;
  final String estado;

  const MenuBilheteDetalhes({
    super.key,
    required this.titulo,
    required this.data,
    required this.estado,
  });

  static const Color verdeEscuro = Color(0xFF1a4d3d);
  static const Color verdeClaro = Color(0xFFA8D4BA);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bilhete'),
        backgroundColor: verdeEscuro,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Bilhete do Evento',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: verdeClaro,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(titulo, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('Data: $data'),
                  Text('Estado: $estado'),
                  const SizedBox(height: 16),
                  QrImageView(
                    data: 'bilhete_estatico_exemplo', // QR estático
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                  const SizedBox(height: 8),
                  const Text('QR Code (estático)'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
