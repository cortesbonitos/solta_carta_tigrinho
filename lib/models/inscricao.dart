class Inscricao {
  final int idInscricao;
  final int idUtilizador;
  final int idEvento;
  final String dataInscricao;

  Inscricao({
    required this.idInscricao,
    required this.idUtilizador,
    required this.idEvento,
    required this.dataInscricao,
  });

  factory Inscricao.fromJson(Map<String, dynamic> json) {
    return Inscricao(
      idInscricao: json['id_inscricao'],
      idUtilizador: json['id_utilizador'],
      idEvento: json['id_evento'],
      dataInscricao: json['data_inscricao'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_inscricao': idInscricao,
      'id_utilizador': idUtilizador,
      'id_evento': idEvento,
      'data_inscricao': dataInscricao,
    };
  }
}
