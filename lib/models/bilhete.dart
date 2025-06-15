class Bilhete {
  final int id;
  final int idEvento;
  final int idUtilizador;
  final String codigo;
  final String dataCriacao;

  Bilhete({
    required this.id,
    required this.idEvento,
    required this.idUtilizador,
    required this.codigo,
    required this.dataCriacao,
  });

  factory Bilhete.fromJson(Map<String, dynamic> json) {
    return Bilhete(
      id: json['id'],
      idEvento: json['idEvento'],
      idUtilizador: json['idUtilizador'],
      codigo: json['codigo'],
      dataCriacao: json['dataCriacao'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idEvento': idEvento,
      'idUtilizador': idUtilizador,
      'codigo': codigo,
      'dataCriacao': dataCriacao,
    };
  }
}
