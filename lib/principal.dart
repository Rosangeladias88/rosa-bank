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
     body: SingleChildScrollView(
  child: Padding(
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
    gradient: const LinearGradient(
      colors: [
        Color(0xFFE91E63),
        Color(0xFF9C27B0),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.3),
        blurRadius: 10,
        offset: const Offset(0, 5),
      ),
    ],
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            'ROSA BANK PREMIUM',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          Icon(
            Icons.credit_card,
            color: Colors.white,
          ),
        ],
      ),

      const SizedBox(height: 30),

      const Text(
        'Saldo disponível',
        style: TextStyle(
          color: Colors.white70,
          fontSize: 14,
        ),
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

      const SizedBox(height: 25),

      const Text(
        'Rosângela Dias',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),

      const SizedBox(height: 8),

      const Text(
        '•••• 4587',
        style: TextStyle(
          color: Colors.white70,
          letterSpacing: 3,
          fontSize: 16,
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
        )),
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