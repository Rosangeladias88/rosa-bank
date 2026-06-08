import 'package:flutter/material.dart';

class ComprovantePage extends StatelessWidget {
  const ComprovantePage({super.key});

  @override
  Widget build(BuildContext context) {
    final dados =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final agora = DateTime.now();
    final protocolo = 'RB${agora.millisecondsSinceEpoch}';

    return Scaffold(
      backgroundColor: const Color(0xFF101827),
      appBar: AppBar(
        title: const Text('Comprovante'),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 90,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Transferência realizada!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      'R\$ ${dados['valor']}',
                      style: const TextStyle(
                        fontSize: 34,
                        color: Colors.pinkAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 24),
                    const Divider(),

                    linhaInfo('Destinatário', dados['nome']),
                    linhaInfo('Chave Pix', dados['pix']),
                    linhaInfo(
                      'Data',
                      '${agora.day}/${agora.month}/${agora.year}',
                    ),
                    linhaInfo(
                      'Hora',
                      '${agora.hour}:${agora.minute.toString().padLeft(2, '0')}',
                    ),
                    linhaInfo('Protocolo', protocolo),

                    const Divider(),
                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/principal',
                            (route) => false,
                          );
                        },
                        icon: const Icon(Icons.home),
                        label: const Text('Voltar ao início'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget linhaInfo(String titulo, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            titulo,
            style: const TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
          ),
          Flexible(
            child: Text(
              valor,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}