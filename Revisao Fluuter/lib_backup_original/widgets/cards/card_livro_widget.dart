import 'package:flutter/material.dart';
import '../../models/livro.dart';

class CardLivroWidget extends StatelessWidget {
  final Livro livro;
  final VoidCallback onRemover;
  final VoidCallback onEmprestar;

  const CardLivroWidget({
    super.key,
    required this.livro,
    required this.onRemover,
    required this.onEmprestar,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(livro.titulo),
        subtitle: Text("Autor: ${livro.autor}"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onRemover,
            ),
            IconButton(
              icon: Icon(
                livro.disponivel ? Icons.book : Icons.bookmark_remove,
                color: livro.disponivel ? Colors.green : Colors.orange,
              ),
              onPressed: onEmprestar,
            ),
          ],
        ),
      ),
    );
  }
}
