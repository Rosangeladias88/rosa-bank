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

  @override
  void initState() {
    super.initState();
    buscarCotacoes();
  }

 Future<void> buscarCotacoes() async {
  try {
    final url = Uri.parse(
      'https://api.hgbrasil.com/finance?format=json&key=611517b7',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final dados = json.decode(response.body);

      setState(() {
        dolar = dados['results']['currencies']['USD']['buy'];
        euro = dados['results']['currencies']['EUR']['buy'];
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
        title: const Text('Cotação'),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
      ),
      body: Center(
        child: carregando
            ? const CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.currency_exchange,
                      size: 80,
                      color: Colors.pinkAccent,
                    ),
                    const SizedBox(height: 20),
                    cardCotacao('Dólar', dolar),
                    const SizedBox(height: 16),
                    cardCotacao('Euro', euro),
                  ],
                ),
              ),
      ),
    );
  }

  Widget cardCotacao(String moeda, double valor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            moeda,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'R\$ ${valor.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 28,
              color: Colors.pinkAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}