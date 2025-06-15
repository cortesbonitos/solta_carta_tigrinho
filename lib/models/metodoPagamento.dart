class MetodoPagamento {
  final int idMetodoPagamento;
  final String nome;

  MetodoPagamento({
    required this.idMetodoPagamento,
    required this.nome,
  });

  factory MetodoPagamento.fromJson(Map<String, dynamic> json) {
    return MetodoPagamento(
      idMetodoPagamento: json['id_metodo_pagamento'],
      nome: json['nome'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_metodo_pagamento': idMetodoPagamento,
      'nome': nome,
    };
  }
}
