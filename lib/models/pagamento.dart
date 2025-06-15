class Pagamento {
  final int idPagamento;
  final String dataPagamento;
  final int idBilhete;
  final int idMetodo;

  Pagamento({
    required this.idPagamento,
    required this.dataPagamento,
    required this.idBilhete,
    required this.idMetodo,
  });
//kajwsfgklsdehnfçalsdhflçaasfsdfasdfas
  factory Pagamento.fromJson(Map<String, dynamic> json) {
    return Pagamento(
      idPagamento: json['id_pagamento'],
      dataPagamento: json['data_pagamento'],
      idBilhete: json['id_bilhete'],
      idMetodo: json['id_metodo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_pagamento': idPagamento,
      'data_pagamento': dataPagamento,
      'id_bilhete': idBilhete,
      'id_metodo': idMetodo,
    };
  }
}
