import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

List<Map<String, dynamic>> historicoTransferencias = [];

Future<void> salvarHistorico() async {
  final prefs = await SharedPreferences.getInstance();

  final listaConvertida = historicoTransferencias.map((transferencia) {
    return {
      'nome': transferencia['nome'],
      'pix': transferencia['pix'],
      'valor': transferencia['valor'],
      'data': transferencia['data'].toString(),
    };
  }).toList();

  await prefs.setString(
    'historicoTransferencias',
    jsonEncode(listaConvertida),
  );
}

Future<void> carregarHistorico() async {
  final prefs = await SharedPreferences.getInstance();

  final historicoSalvo = prefs.getString('historicoTransferencias');

  if (historicoSalvo != null) {
    final listaDecodificada = jsonDecode(historicoSalvo) as List;

    historicoTransferencias = listaDecodificada.map((item) {
      return {
        'nome': item['nome'],
        'pix': item['pix'],
        'valor': item['valor'],
        'data': DateTime.parse(item['data']),
      };
    }).toList();
  }
}