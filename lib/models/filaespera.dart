class FilaEspera {
  final int idFila;
  final String dataEntrada;
  final int idUtilizador;
  final int idEvento;

  FilaEspera({
    required this.idFila,
    required this.dataEntrada,
    required this.idUtilizador,
    required this.idEvento,
  });

  factory FilaEspera.fromJson(Map<String, dynamic> json) {
    return FilaEspera(
      idFila: json['id_fila'],
      dataEntrada: json['data_entrada'],
      idUtilizador: json['id_utilizador'],
      idEvento: json['id_evento'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_fila': idFila,
      'data_entrada': dataEntrada,
      'id_utilizador': idUtilizador,
      'id_evento': idEvento,
    };
  }
}
