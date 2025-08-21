import 'package:flutter/material.dart';
import '../../models/emprestimo.dart';
import '../../models/livro.dart';

class FormularioEmprestimoWidget extends StatefulWidget {
  final Livro livro;
  final Function(Emprestimo) onSalvar;
  final VoidCallback? onCancelar;

  const FormularioEmprestimoWidget({
    super.key,
    required this.livro,
    required this.onSalvar,
    this.onCancelar,
  });

  @override
  State<FormularioEmprestimoWidget> createState() =>
      _FormularioEmprestimoWidgetState();
}

class _FormularioEmprestimoWidgetState
    extends State<FormularioEmprestimoWidget> {
  final _formKey = GlobalKey<FormState>();
  late String _nomeUsuario;

  bool _isProcessando = false;

  @override
  void initState() {
    super.initState();
    _nomeUsuario = '';
  }

  Future<void> _salvar() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isProcessando = true);

    await Future.delayed(const Duration(seconds: 1));

    final emprestimo = Emprestimo(
      livro: widget.livro,
      nomeUsuario: _nomeUsuario,
    );

    widget.onSalvar(emprestimo);

    setState(() => _isProcessando = false);

    if (widget.onCancelar != null) widget.onCancelar!();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Novo Empréstimo - ${widget.livro.titulo}"),
      content: Form(
        key: _formKey,
        child: TextFormField(
          decoration: const InputDecoration(labelText: "Nome do Usuário"),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Informe o nome do usuário';
            }
            return null;
          },
          onChanged: (value) => _nomeUsuario = value,
        ),
      ),
      actions: [
        if (widget.onCancelar != null)
          TextButton(
            onPressed: widget.onCancelar,
            child: const Text("Cancelar"),
          ),
        ElevatedButton(
          onPressed: _isProcessando ? null : _salvar,
          child: _isProcessando
              ? const CircularProgressIndicator()
              : const Text("Salvar"),
        )
      ],
    );
  }
}
