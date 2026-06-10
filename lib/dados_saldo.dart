import 'package:shared_preferences/shared_preferences.dart';

double saldoDisponivel = 2500.00;

Future<void> salvarSaldo() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setDouble('saldoDisponivel', saldoDisponivel);
}

Future<void> carregarSaldo() async {
  final prefs = await SharedPreferences.getInstance();
  saldoDisponivel = prefs.getDouble('saldoDisponivel') ?? 2500.00;
}