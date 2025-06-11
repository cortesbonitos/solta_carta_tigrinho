class MetodoPagamento {
  int idMetodo;
  String nome;
  List<dynamic> pagamento; // Substitua por List<Pagamento> se tiver a classe Pagamento

  MetodoPagamento({
    required this.idMetodo,
    required this.nome,
    required this.pagamento,
  });

  factory MetodoPagamento.fromJson(Map<String, dynamic> json) {
    return MetodoPagamento(
      idMetodo: json['id_metodo'],
      nome: json['Nome'],
      pagamento: json['Pagamento'] ?? [],
    );
  }

  @override
  String toString() {
    return 'MetodoPagamento(idMetodo: $idMetodo, nome: $nome, pagamento: $pagamento)';
  }
}