import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/storage.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String author = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    final storage = Provider.of<Storage>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar Livro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Título'),
                onSaved: (v) => title = v?.trim() ?? '',
                validator: (v) => (v==null || v.trim().isEmpty) ? 'Informe o título' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Autor'),
                onSaved: (v) => author = v?.trim() ?? '',
                validator: (v) => (v==null || v.trim().isEmpty) ? 'Informe o autor' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Descrição (opcional)'),
                onSaved: (v) => description = v?.trim() ?? '',
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('Salvar'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    storage.addBook(title, author, description);
                    Navigator.of(context).pop();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}