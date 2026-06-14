import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _formCadastro = GlobalKey<FormState>();

  bool mostrarSenha = false;
  bool mostrarConfirmarSenha = false;

  String nome = '';
  String cpf = '';
  String email = '';
  String telefone = '';
  String senha = '';

  Future<void> criarConta() async {
    if (_formCadastro.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString('nome', nome);
      await prefs.setString('cpf', cpf);
      await prefs.setString('email', email);
      await prefs.setString('telefone', telefone);
      await prefs.setString('senha', senha);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Conta criada com sucesso!'),
        ),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101827),
      appBar: AppBar(
        title: const Text('Cadastro'),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formCadastro,
            child: Column(
              children: [
                const Icon(
                  Icons.account_balance,
                  size: 70,
                  color: Colors.pinkAccent,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Criar conta Rosa Bank',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),

                campoTexto(
                  'Nome completo',
                  Icons.person,
                  (value) => nome = value,
                ),

                const SizedBox(height: 16),

                campoTexto(
                  'CPF',
                  Icons.badge,
                  (value) => cpf = value,
                ),

                const SizedBox(height: 16),

                campoTexto(
                  'E-mail',
                  Icons.email,
                  (value) => email = value,
                ),

                const SizedBox(height: 16),

                campoTexto(
                  'Telefone',
                  Icons.phone,
                  (value) => telefone = value,
                ),

                const SizedBox(height: 16),

                TextFormField(
                  obscureText: !mostrarSenha,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    labelStyle: const TextStyle(color: Colors.white70),
                    prefixIcon: const Icon(Icons.lock, color: Colors.white70),
                    suffixIcon: IconButton(
                      icon: Icon(
                        mostrarSenha
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.white70,
                      ),
                      onPressed: () {
                        setState(() {
                          mostrarSenha = !mostrarSenha;
                        });
                      },
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white38),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.pinkAccent),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe uma senha';
                    }
                    if (value.length < 6) {
                      return 'A senha deve ter pelo menos 6 caracteres';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    senha = value;
                  },
                ),

                const SizedBox(height: 16),

                TextFormField(
                  obscureText: !mostrarConfirmarSenha,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Confirmar senha',
                    labelStyle: const TextStyle(color: Colors.white70),
                    prefixIcon: const Icon(Icons.lock, color: Colors.white70),
                    suffixIcon: IconButton(
                      icon: Icon(
                        mostrarConfirmarSenha
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.white70,
                      ),
                      onPressed: () {
                        setState(() {
                          mostrarConfirmarSenha = !mostrarConfirmarSenha;
                        });
                      },
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white38),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.pinkAccent),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Confirme sua senha';
                    }
                    if (value != senha) {
                      return 'As senhas não são iguais';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: criarConta,
                    child: const Text('Criar Conta'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget campoTexto(
    String label,
    IconData icone,
    Function(String) onChanged,
  ) {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        prefixIcon: Icon(icone, color: Colors.white70),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white38),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.pinkAccent),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Preencha o campo $label';
        }
        return null;
      },
      onChanged: onChanged,
    );
  }
}