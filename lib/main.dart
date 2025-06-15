import 'package:flutter/material.dart';
import 'menu_inicial.dart'; // já deve existir

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Eventos',
      debugShowCheckedModeBanner: false,
      home: const MenuInicial(),
    );
  }
}
