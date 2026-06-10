import 'package:flutter/material.dart';
import 'login.dart';
import 'principal.dart';
import 'cotacao.dart';
import 'transferencia.dart';
import 'historico.dart';
import 'comprovante.dart';
import 'dados_saldo.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await carregarSaldo();

  runApp(const RosaBankApp());
}

class RosaBankApp extends StatelessWidget {
  const RosaBankApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rosa Bank',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/principal': (context) => const PrincipalPage(),
        '/cotacao': (context) => const CotacaoPage(),
        '/transferencia': (context) => const TransferenciaPage(),
        '/historico': (context) => const HistoricoPage(),
        '/comprovante': (context) => const ComprovantePage(),
      },
    );
  }
}