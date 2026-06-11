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
                                historicoTransferencias[index]['valor']
                                    .toString(),
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
}