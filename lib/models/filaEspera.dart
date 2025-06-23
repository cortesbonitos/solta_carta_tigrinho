class FilaEspera {
  final int? idFila;
  final DateTime dataEntrada;
  final int idUtilizador;
  final int idEvento;

  FilaEspera({
    this.idFila,
    required this.dataEntrada,
    required this.idUtilizador,
    required this.idEvento,
  });

  factory FilaEspera.fromJson(Map<String, dynamic> json) {
    return FilaEspera(
      idFila: json['id_fila'],
      dataEntrada: DateTime.parse(json['data_entrada']),
      idUtilizador: json['id_utilizador'],
      idEvento: json['id_evento'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data_entrada': dataEntrada.toIso8601String(),
      'id_utilizador': idUtilizador,
      'id_evento': idEvento,
    };
  }
}
