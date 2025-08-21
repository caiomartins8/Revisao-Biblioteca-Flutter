import 'livro.dart';

class Emprestimo {
  int? id;
  final Livro livro;
  final String nomeUsuario;
  final DateTime dataEmprestimo;
  final DateTime dataPrevistaDevolucao;
  DateTime? dataDevolucao;
  bool ativo;

  Emprestimo({
    this.id,
    required this.livro,
    required this.nomeUsuario,
    DateTime? dataEmprestimo,
    DateTime? dataPrevistaDevolucao,
    this.dataDevolucao,
    this.ativo = true,
  })  : dataEmprestimo = dataEmprestimo ?? DateTime.now(),
        dataPrevistaDevolucao =
            dataPrevistaDevolucao ?? DateTime.now().add(const Duration(days: 7));

  // verifica se está atrasado
  bool get estaAtrasado {
    if (!ativo) return false;
    if (dataDevolucao != null) return false;
    return DateTime.now().isAfter(dataPrevistaDevolucao);
  }
}
