import 'package:flutter/material.dart';
import 'dados_saldo.dart';
import 'dados_transferencia.dart';

class PrincipalPage extends StatefulWidget {
  const PrincipalPage({super.key});

  @override
  State<PrincipalPage> createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> {
  bool mostrarSaldo = true;

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
                'Bem-vinda ao Rosa Bank',
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
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.35),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'ROSA BANK PREMIUM',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                        Icon(
                          Icons.credit_card,
                          color: Colors.white,
                          size: 30,
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    const Text(
                      'Saldo disponível',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          mostrarSaldo
                              ? 'R\$ ${saldoDisponivel.toStringAsFixed(2)}'
                              : 'R\$ ••••••',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              mostrarSaldo = !mostrarSaldo;
                            });
                          },
                          icon: Icon(
                            mostrarSaldo
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 22),

                    const Text(
                      'Rosângela Dias',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Agência 0001  •  Conta 12345-7',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 16),

                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '•••• 4587',
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 3,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Validade 12/30',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  atalhoMenu(
                    context,
                    titulo: 'Cotação',
                    icone: Icons.currency_exchange,
                    rota: '/cotacao',
                  ),
                  atalhoMenu(
                    context,
                    titulo: 'Pix',
                    icone: Icons.pix,
                    rota: '/transferencia',
                  ),
                  atalhoMenu(
                    context,
                    titulo: 'Histórico',
                    icone: Icons.history,
                    rota: '/historico',
                  ),
                ],
              ),

              const SizedBox(height: 30),

              const Text(
                'Últimas movimentações',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: historicoTransferencias.isEmpty
                    ? const Text(
                        'Nenhuma movimentação ainda',
                        style: TextStyle(color: Colors.white70),
                      )
                    : Column(
                        children: historicoTransferencias
                            .reversed
                            .take(3)
                            .map((transferencia) {
                          return ListTile(
                            leading: const Icon(
                              Icons.arrow_upward,
                              color: Colors.red,
                            ),
                            title: Text(
                              'Pix para ${transferencia['nome']}',
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              'R\$ ${transferencia['valor']}',
                              style: const TextStyle(color: Colors.white70),
                            ),
                          );
                        }).toList(),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget atalhoMenu(
    BuildContext context, {
    required String titulo,
    required IconData icone,
    required String rota,
  }) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, rota),
      child: Column(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.white24,
            child: Icon(
              icone,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            titulo,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}