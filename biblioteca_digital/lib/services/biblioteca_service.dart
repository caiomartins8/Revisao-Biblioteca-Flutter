import '../models/livro.dart';
import '../models/emprestimo.dart';
import '../models/usuario.dart';

class BibliotecaService {
  static final BibliotecaService _instance = BibliotecaService._internal();
  factory BibliotecaService() => _instance;
  BibliotecaService._internal();

  List<Livro> livros = [];
  List<Emprestimo> emprestimos = [];

  void emprestarLivro(Livro livro, Usuario usuario) {
    if (!livro.emprestado) {
      livro.emprestado = true;
      emprestimos.add(Emprestimo(livro: livro, usuario: usuario));
    }
  }
}
