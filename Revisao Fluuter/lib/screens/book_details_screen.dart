import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/storage.dart';
import '../models/book.dart';

class BookDetailsScreen extends StatelessWidget {
  final String bookId;
  const BookDetailsScreen({required this.bookId, super.key});

  @override
  Widget build(BuildContext context) {
    final storage = Provider.of<Storage>(context);
    final book = storage.books.firstWhere((b) => b.id == bookId);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Livro'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              storage.removeBook(book.id);
              Navigator.of(context).pop();
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(book.title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text('Autor: ${book.author}', style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 12),
            Text(book.description.isEmpty ? 'Sem descrição' : book.description),
            const SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton.icon(
                  icon: Icon(book.borrowed ? Icons.undo : Icons.book),
                  label: Text(book.borrowed ? 'Devolver' : 'Emprestar'),
                  onPressed: () {
                    storage.toggleBorrow(book.id);
                  },
                ),
                const SizedBox(width: 12),
                if (book.borrowed && book.borrowedAt != null) Text('Emprestado em: ${book.borrowedAt}'),
              ],
            )
          ],
        ),
      ),
    );
  }
}