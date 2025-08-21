class Livro {
  int? id;
  final String titulo;
  final String autor;
  bool disponivel;

  Livro({
    this.id,
    required this.titulo,
    required this.autor,
    this.disponivel = true,
  });

  Livro copyWith({int? id, String? titulo, String? autor, bool? disponivel}) {
    return Livro(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      autor: autor ?? this.autor,
      disponivel: disponivel ?? this.disponivel,
    );
  }
}
