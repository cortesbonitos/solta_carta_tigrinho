class Pagamento {
  int? idPagamento;
  DateTime dataPagamento;
  int idBilhete;
  int idMetodo;

  Pagamento({
    this.idPagamento,
    required this.dataPagamento,
    required this.idBilhete,
    required this.idMetodo,
  });

  factory Pagamento.fromJson(Map<String, dynamic> json) {
    return Pagamento(
      idPagamento: json['id_pagamento'],
      dataPagamento: DateTime.parse(json['data_pagamento']),
      idBilhete: json['id_bilhete'],
      idMetodo: json['id_metodo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data_pagamento': dataPagamento.toIso8601String(),
      'id_bilhete': idBilhete,
      'id_metodo': idMetodo,
    };
  }
}
