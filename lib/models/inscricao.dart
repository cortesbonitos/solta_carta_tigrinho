class Inscricao {
  final int id_inscricao;
  final int idUtilizador;
  final int idEvento;
  final DateTime dataInscricao;

  Inscricao({
    required this.id_inscricao,
    required this.idUtilizador,
    required this.idEvento,
    required this.dataInscricao,
  });

  factory Inscricao.fromJson(Map<String, dynamic> json) {
    return Inscricao(
      id_inscricao: json['id_inscricao'],
      idUtilizador: json['id_utilizador'],
      idEvento: json['id_evento'],
      dataInscricao: DateTime.parse(json['data_inscricao']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_inscricao': id_inscricao,
      'id_utilizador': idUtilizador,
      'id_evento': idEvento,
      'data_inscricao': dataInscricao.toIso8601String(),
    };
  }
}
