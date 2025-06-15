class Inscricao {
   int? idInscricao;
  final int idUtilizador;
  final int idEvento;
  final DateTime dataInscricao;

  Inscricao({
     this.idInscricao,
    required this.idUtilizador,
    required this.idEvento,
    required this.dataInscricao,
  });

  factory Inscricao.fromJson(Map<String, dynamic> json) {
    return Inscricao(
      idInscricao: json['id_inscricao'],
      idUtilizador: json['id_utilizador'],
      idEvento: json['id_evento'],
      dataInscricao: DateTime.parse(json['data_inscricao']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_utilizador': idUtilizador,
      'id_evento': idEvento,
      'data_inscricao': dataInscricao,
    };
  }
  @override
  String toString() {
    return 'Inscricao{idInscricao: $idInscricao, idUtilizador: $idUtilizador, idEvento: $idEvento, dataInscricao: $dataInscricao}';
  }

}
