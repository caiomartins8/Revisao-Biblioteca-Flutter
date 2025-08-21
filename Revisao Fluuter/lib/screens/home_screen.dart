import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/storage.dart';
import '../models/book.dart';
import 'add_book_screen.dart';
import 'book_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = Provider.of<Storage>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biblioteca Digital'),
        actions: [
          IconButton(
            tooltip: 'Adicionar Livro',
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AddBookScreen())),
          )
        ],
      ),
      body: SafeArea(
        child: storage.books.isEmpty
            ? const Center(child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Nenhum livro cadastrado. Toque no + para adicionar.', textAlign: TextAlign.center),
              ))
            : ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: storage.books.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, i) {
                  final Book b = storage.books[i];
                  return ListTile(
                    tileColor: Theme.of(context).colorScheme.surfaceVariant,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    leading: const Icon(Icons.book, size: 36),
                    title: Text(b.title, style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text(b.author),
                    trailing: Wrap(spacing: 8, children: [
                      IconButton(
                        icon: Icon(b.borrowed ? Icons.check_circle : Icons.circle_outlined),
                        tooltip: b.borrowed ? 'Devolver' : 'Emprestar',
                        onPressed: () => storage.toggleBorrow(b.id),
                      ),
                      IconButton(
                        icon: const Icon(Icons.more_horiz),
                        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => BookDetailsScreen(bookId: b.id))),
                      )
                    ]),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => BookDetailsScreen(bookId: b.id))),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AddBookScreen())),
        child: const Icon(Icons.add),
      ),
    );
  }
}