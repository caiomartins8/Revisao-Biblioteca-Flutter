import 'package:flutter/material.dart';
import '../models/emprestimo.dart';
import '../models/livro.dart';
import '../widgets/formularios/formulario_emprestimo_widget.dart';

class GerenciarEmprestimosScreen extends StatefulWidget {
  const GerenciarEmprestimosScreen({super.key});

  @override
  State<GerenciarEmprestimosScreen> createState() =>
      _GerenciarEmprestimosScreenState();
}

class _GerenciarEmprestimosScreenState
    extends State<GerenciarEmprestimosScreen> {
  final List<Emprestimo> _emprestimos = [];

  void _novoEmprestimo(Livro livro) {
    showDialog(
      context: context,
      builder: (_) => FormularioEmprestimoWidget(
        livro: livro,
        onSalvar: (emprestimo) {
          setState(() {
            _emprestimos.add(emprestimo);
          });
          Navigator.pop(context);
        },
        onCancelar: () => Navigator.pop(context),
      ),
    );
  }

  void _finalizarEmprestimo(Emprestimo emprestimo) {
    setState(() {
      emprestimo.ativo = false;
      emprestimo.dataDevolucao = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Gerenciar Empréstimos")),
      body: _emprestimos.isEmpty
          ? const Center(child: Text("Nenhum empréstimo registrado."))
          : ListView.builder(
              itemCount: _emprestimos.length,
              itemBuilder: (context, index) {
                final emprestimo = _emprestimos[index];
                return Card(
                  child: ListTile(
                    title: Text(emprestimo.livro.titulo),
                    subtitle: Text(
                      "Usuário: ${emprestimo.nomeUsuario}\n"
                      "Data: ${emprestimo.dataEmprestimo.toLocal().toString().split(' ')[0]}",
                    ),
                    trailing: emprestimo.ativo
                        ? IconButton(
                            icon: const Icon(Icons.done, color: Colors.green),
                            onPressed: () => _finalizarEmprestimo(emprestimo),
                          )
                        : const Text("Devolvido"),
                  ),
                );
              },
            ),
    );
  }
}
