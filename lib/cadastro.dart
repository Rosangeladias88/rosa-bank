import 'package:flutter/material.dart';

class CadastroPage extends StatelessWidget {
  const CadastroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101827),
      appBar: AppBar(
        title: const Text('Cadastro'),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Tela de cadastro em desenvolvimento',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}