import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CotacaoPage extends StatefulWidget {
  const CotacaoPage({super.key});

  @override
  State<CotacaoPage> createState() => _CotacaoPageState();
}

class _CotacaoPageState extends State<CotacaoPage> {
  double dolar = 0.0;
  double euro = 0.0;
  bool carregando = true;
  final realController = TextEditingController();
  double valorEmDolar = 0.0;
  double valorEmEuro = 0.0;

void converterMoedas() {
  final valorReal = double.tryParse(realController.text.replaceAll(',', '.')) ?? 0.0;

  setState(() {
    valorEmDolar = valorReal / dolar;
    valorEmEuro = valorReal / euro;
  });
}

  @override
  void initState() {
    super.initState();
    buscarCotacoes();
  }

  Future<void> buscarCotacoes() async {
    setState(() {
      carregando = true;
    });

    try {
      final url = Uri.parse(
        'https://economia.awesomeapi.com.br/json/last/USD-BRL,EUR-BRL',
);

      final response = await http.get(url);
      print(response.body);

      if (response.statusCode == 200) {
        final dados = json.decode(response.body);

        setState(() {
          dolar = double.parse(dados['USDBRL']['bid']);
          euro = double.parse(dados['EURBRL']['bid']);
          carregando = false;
        });
      } else {
        setState(() {
          carregando = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro ao buscar cotações.'),
          ),
        );
      }
    } catch (erro) {
      setState(() {
        carregando = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Falha de conexão com a API.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101827),
      appBar: AppBar(
        title: const Text('Cotação de Moedas'),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
      ),
      body: carregando
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.pinkAccent,
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Cotações em tempo real',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Valores consultados pela API financeira.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 30),

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
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.currency_exchange,
                            color: Colors.white,
                            size: 42,
                          ),
                          SizedBox(height: 18),
                          Text(
                            'Conversor Rosa Bank',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Acompanhe dólar e euro atualizados.',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    cardCotacao(
                      moeda: 'Dólar',
                      sigla: 'USD',
                      valor: dolar,
                      icone: Icons.attach_money,
                    ),

                    const SizedBox(height: 16),

                    cardCotacao(
  moeda: 'Euro',
  sigla: 'EUR',
  valor: euro,
  icone: Icons.euro,
),

const SizedBox(height: 20),

TextField(
  controller: realController,
  keyboardType: TextInputType.number,
  decoration: const InputDecoration(
    labelText: 'Digite um valor em reais',
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(),
  ),
),

const SizedBox(height: 16),

SizedBox(
  width: double.infinity,
  height: 50,
  child: ElevatedButton(
    onPressed: converterMoedas,
    child: const Text('Converter'),
  ),
),

const SizedBox(height: 16),

Container(
  width: double.infinity,
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Colors.white10,
    borderRadius: BorderRadius.circular(16),
  ),
  child: Column(
    children: [
      Text(
        'Em dólar: US\$ ${valorEmDolar.toStringAsFixed(2)}',
        style: const TextStyle(color: Colors.white),
      ),
      SizedBox(height: 8),
      Text(
        'Em euro: € ${valorEmEuro.toStringAsFixed(2)}',
        style: const TextStyle(color: Colors.white),
      ),
    ],
  ),
),

const SizedBox(height: 20),

SizedBox(
  width: double.infinity,
  height: 50,
  child: ElevatedButton.icon(
                        onPressed: buscarCotacoes,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Atualizar cotação'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget cardCotacao({
    required String moeda,
    required String sigla,
    required double valor,
    required IconData icone,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.pinkAccent.withOpacity(0.2),
            child: Icon(
              icone,
              color: Colors.pinkAccent,
              size: 30,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  moeda,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  sigla,
                  style: const TextStyle(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          Text(
            'R\$ ${valor.toStringAsFixed(2)}',
            style: const TextStyle(
              color: Colors.pinkAccent,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}