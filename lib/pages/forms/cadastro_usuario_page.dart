import 'package:flutter/material.dart';

class CadastroUsuarioPage extends StatelessWidget {
  final String tipoUsuario; // "Morador" ou "Coletor"

  const CadastroUsuarioPage({super.key, required this.tipoUsuario});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text('Cadastro de $tipoUsuario')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nome Completo'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'E-mail'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passController,
              decoration: const InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Apenas imprime no console por simplicidade
                  print("Cadastrando $tipoUsuario: ${nameController.text}");
                  Navigator.pop(context); // Volta para o menu
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$tipoUsuario cadastrado com sucesso!')),
                  );
                },
                child: const Text('Finalizar Cadastro'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}