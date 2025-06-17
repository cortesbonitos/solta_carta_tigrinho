class Avaliacao {
  final int idAvaliacao;
  final int pontuacao;
  final int idUtilizador;
  final int idEvento;
  final String? comentario;

  Avaliacao({
    required this.idAvaliacao,
    required this.pontuacao,
    required this.idUtilizador,
    required this.idEvento,
    this.comentario,
  });

  factory Avaliacao.fromJson(Map<String, dynamic> json) {
    return Avaliacao(
      idAvaliacao: json['id_avaliacao'],
      pontuacao: json['pontuacao'],
      idUtilizador: json['id_utilizador'],
      idEvento: json['id_evento'],
      comentario: json['comentario'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_avaliacao': idAvaliacao,
      'pontuacao': pontuacao,
      'id_utilizador': idUtilizador,
      'id_evento': idEvento,
      'comentario': comentario,
    };
  }
}
