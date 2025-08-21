import 'package:flutter/material.dart';
import '../models/livro.dart';
import '../services/biblioteca_service.dart';
import '../widgets/listas/lista_livros_widget.dart';

class GerenciarLivrosScreen extends StatefulWidget {
  const GerenciarLivrosScreen({super.key});

  @override
  State<GerenciarLivrosScreen> createState() => _GerenciarLivrosScreenState();
}

class _GerenciarLivrosScreenState extends State<GerenciarLivrosScreen> {
  final BibliotecaService _service = BibliotecaService();

  final TextEditingController _tituloCtrl = TextEditingController();
  final TextEditingController _autorCtrl = TextEditingController();

  void _adicionarLivro() {
    if (_tituloCtrl.text.isEmpty || _autorCtrl.text.isEmpty) return;

    final livro = Livro(titulo: _tituloCtrl.text, autor: _autorCtrl.text);
    setState(() {
      _service.adicionarLivro(livro);
    });

    _tituloCtrl.clear();
    _autorCtrl.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Gerenciar Livros")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _tituloCtrl,
                    decoration: const InputDecoration(labelText: "Título"),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _autorCtrl,
                    decoration: const InputDecoration(labelText: "Autor"),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _adicionarLivro,
                )
              ],
            ),
          ),
          Expanded(
            child: ListaLivrosWidget(
              livros: _service.livros,
              onRemover: (livro) {
                setState(() => _service.removerLivro(livro));
              },
              onEmprestar: (livro) {
                setState(() => _service.alternarDisponibilidade(livro));
              },
            ),
          )
        ],
      ),
    );
  }
}
