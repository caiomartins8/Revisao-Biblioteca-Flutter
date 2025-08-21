import 'package:flutter/material.dart';
import 'gerenciar_livros_screen.dart';
import 'gerenciar_emprestimos_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Biblioteca Digital")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text("Gerenciar Livros"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const GerenciarLivrosScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Gerenciar Empréstimos"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const GerenciarEmprestimosScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
