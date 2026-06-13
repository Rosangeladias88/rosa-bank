import 'package:flutter/material.dart';
import 'login.dart';
import 'principal.dart';
import 'cotacao.dart';
import 'transferencia.dart';
import 'historico.dart';
import 'comprovante.dart';
import 'dados_saldo.dart';
import 'dados_transferencia.dart';
import 'tema.dart';
import 'cadastro.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await carregarSaldo();
  await carregarHistorico();

  runApp(const RosaBankApp());
}

class RosaBankApp extends StatelessWidget {
  const RosaBankApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
  valueListenable: temaAtual,
  builder: (context, ThemeMode modo, child) {
    return MaterialApp(
      title: 'Rosa Bank',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: modo,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/principal': (context) => const PrincipalPage(),
        '/cotacao': (context) => const CotacaoPage(),
        '/transferencia': (context) => const TransferenciaPage(),
        '/historico': (context) => const HistoricoPage(),
        '/comprovante': (context) => const ComprovantePage(),
        '/cadastro':(context) => const CadastroPage(),
      },
    );
  },
);
  }
}