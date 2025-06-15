class Bilhete {
  final int idBilhete;
  final double valor;
  final int idInscricao;

  Bilhete({
    required this.idBilhete,
    required this.valor,
    required this.idInscricao,
  });

  factory Bilhete.fromJson(Map<String, dynamic> json) {
    return Bilhete(
      idBilhete: json['id_bilhete'],
      valor: json['valor'].toDouble(),
      idInscricao: json['id_inscricao'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_bilhete': idBilhete,
      'valor': valor,
      'id_inscricao': idInscricao,
    };
  }
}
