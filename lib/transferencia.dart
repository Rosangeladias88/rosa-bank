import 'dados_saldo.dart';
import 'dados_transferencia.dart';
import 'package:flutter/material.dart';

class TransferenciaPage extends StatefulWidget {
  const TransferenciaPage({super.key});

  @override
  State<TransferenciaPage> createState() => _TransferenciaPageState();
}

class _TransferenciaPageState extends State<TransferenciaPage> {
  final _formTransferencia = GlobalKey<FormState>();

  final nomeController = TextEditingController();
  final pixController = TextEditingController();
  final valorController = TextEditingController();

 void transferir() {
  if (_formTransferencia.currentState!.validate()) {
    final valorTransferencia = double.parse(valorController.text);

    if (valorTransferencia > saldoDisponivel) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Saldo insuficiente!'),
        ),
      );
      return;
    }

    saldoDisponivel = saldoDisponivel - valorTransferencia;

    final transferencia = {
      'nome': nomeController.text,
      'pix': pixController.text,
      'valor': valorController.text,
      'data': DateTime.now(),
    };

    historicoTransferencias.add(transferencia);

    Navigator.pushNamedAndRemoveUntil(
      context,
      '/comprovante',
      (route) => false,
      arguments: transferencia,
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101827),
      appBar: AppBar(
        title: const Text('Transferência'),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formTransferencia,
          child: Column(
            children: [
              TextFormField(
                controller: nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome do destinatário',
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o nome do destinatário';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: pixController,
                decoration: const InputDecoration(
                  labelText: 'Chave Pix',
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe a chave Pix';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: valorController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Valor',
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o valor';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: transferir,
                  child: const Text('Transferir'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}