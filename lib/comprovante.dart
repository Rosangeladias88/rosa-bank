import 'package:flutter/material.dart';

class ComprovantePage extends StatelessWidget {
  const ComprovantePage({super.key});

  @override
  Widget build(BuildContext context) {
    final dados =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      backgroundColor: const Color(0xFF101827),
      appBar: AppBar(
        title: const Text('Comprovante'),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 80,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Transferência realizada!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Text('Destinatário: ${dados['nome']}'),
                Text('PIX: ${dados['pix']}'),
                Text('Valor: R\$ ${dados['valor']}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}