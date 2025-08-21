import 'package:flutter/material.dart';
import '../../models/livro.dart';
import '../cards/card_livro_widget.dart';

class ListaLivrosWidget extends StatelessWidget {
  final List<Livro> livros;
  final Function(Livro) onRemover;
  final Function(Livro) onEmprestar;

  const ListaLivrosWidget({
    super.key,
    required this.livros,
    required this.onRemover,
    required this.onEmprestar,
  });

  @override
  Widget build(BuildContext context) {
    if (livros.isEmpty) {
      return const Center(
        child: Text("Nenhum livro cadastrado."),
      );
    }

    return ListView.builder(
      itemCount: livros.length,
      itemBuilder: (context, index) {
        final livro = livros[index];
        return CardLivroWidget(
          livro: livro,
          onRemover: () => onRemover(livro),
          onEmprestar: () => onEmprestar(livro),
        );
      },
    );
  }
}
