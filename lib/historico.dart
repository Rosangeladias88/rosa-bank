import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
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
          : Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    'Evolução das Transferências',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Container(
                  height: 250,
                  padding: const EdgeInsets.all(16),
                  child: LineChart(
                    LineChartData(
                      borderData: FlBorderData(show: false),
                      gridData: FlGridData(show: true),
                      titlesData: FlTitlesData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots: List.generate(
                            historicoTransferencias.length,
                            (index) => FlSpot(
                              index.toDouble(),
                              double.parse(
                                historicoTransferencias[index]['valor'].toString(),
                              ),
                            ),
                          ),
                          isCurved: true,
                          barWidth: 4,
                          dotData: FlDotData(show: true),
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          resumoCard('Pix', '${historicoTransferencias.length}'),
                          resumoCard(
                            'Total',
                            'R\$ ${historicoTransferencias.fold(
                              0.0,
                              (soma, item) =>
                                  soma + double.parse(item['valor'].toString()),
                            ).toStringAsFixed(2)}',
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          resumoCard(
                            'Maior Pix',
                            'R\$ ${historicoTransferencias.map(
                              (e) => double.parse(e['valor'].toString()),
                            ).reduce((a, b) => a > b ? a : b).toStringAsFixed(2)}',
                          ),
                          resumoCard(
                            'Menor Pix',
                            'R\$ ${historicoTransferencias.map(
                              (e) => double.parse(e['valor'].toString()),
                            ).reduce((a, b) => a < b ? a : b).toStringAsFixed(2)}',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                Expanded(
                  child: ListView.builder(
                    itemCount: historicoTransferencias.length,
                    itemBuilder: (context, index) {
                      final transferencia = historicoTransferencias[
                          historicoTransferencias.length - 1 - index];

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
                ),
              ],
            ),
    );
  }

  Widget resumoCard(String titulo, String valor) {
    return Container(
      width: 130,
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            titulo,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            valor,
            style: const TextStyle(
              color: Colors.pinkAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}