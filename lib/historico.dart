import 'package:flutter/material.dart';

class HistoricoPage extends StatelessWidget {
  const HistoricoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> historico = [
      'Transferência de R\$ 150,00 para Maria',
      'Transferência de R\$ 80,00 para João',
      'Cotação consultada: Dólar e Euro',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico'),
      ),
      body: ListView.builder(
        itemCount: historico.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: const Icon(Icons.receipt_long),
              title: Text(historico[index]),
            ),
          );
        },
      ),
    );
  }
}