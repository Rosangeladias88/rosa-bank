import 'package:flutter/material.dart';
import 'dados_transferencia.dart';

class HistoricoPage extends StatelessWidget {
  const HistoricoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101827),
      appBar: AppBar(
        title: const Text('Histórico'),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
      ),
      body: historicoTransferencias.isEmpty
          ? const Center(
              child: Text(
                'Nenhuma transferência realizada ainda.',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: historicoTransferencias.length,
              itemBuilder: (context, index) {
                final transferencia =
    historicoTransferencias[historicoTransferencias.length - 1 - index];

                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: const Icon(
                      Icons.account_balance_wallet,
                      color: Colors.green,
                    ),
                    title: Text(
                      "R\$ ${transferencia['valor']}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
  "Para: ${transferencia['nome']}\n"
  "Data: ${transferencia['data'].day}/${transferencia['data'].month}/${transferencia['data'].year} "
  "- ${transferencia['data'].hour}:${transferencia['data'].minute.toString().padLeft(2, '0')}",
),
                  ),
                );
              },
            ),
    );
  }
}