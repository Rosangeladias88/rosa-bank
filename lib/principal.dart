import 'package:flutter/material.dart';
import 'dados_saldo.dart';

class PrincipalPage extends StatelessWidget {
  const PrincipalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101827),
      appBar: AppBar(
        title: const Text('Rosa Bank'),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Olá, amiga!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.pinkAccent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Saldo disponível',
                    style: TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'R\$ ${saldoDisponivel.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            botaoMenu(
              context,
              titulo: 'Cotação de Moedas',
              icone: Icons.currency_exchange,
              rota: '/cotacao',
            ),

            botaoMenu(
              context,
              titulo: 'Transferência',
              icone: Icons.pix,
              rota: '/transferencia',
            ),

            botaoMenu(
              context,
              titulo: 'Histórico',
              icone: Icons.history,
              rota: '/historico',
            ),
          ],
        ),
      ),
    );
  }

  Widget botaoMenu(
    BuildContext context, {
    required String titulo,
    required IconData icone,
    required String rota,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.pushNamed(context, rota);
          },
          icon: Icon(icone),
          label: Text(titulo),
        ),
      ),
    );
  }
}