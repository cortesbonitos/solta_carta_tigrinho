class Morada {
  final int idMorada;
  final String codigoPostal;
  final String rua;
  final int numeroPorta;
  final String freguesia;
  final String localidade;
  final String? complemento;

  Morada({
    required this.idMorada,
    required this.codigoPostal,
    required this.rua,
    required this.numeroPorta,
    required this.freguesia,
    required this.localidade,
    this.complemento,
  });

  factory Morada.fromJson(Map<String, dynamic> json) {
    return Morada(
      idMorada: json['id_morada'],
      codigoPostal: json['codigo_postal'],
      rua: json['rua'],
      numeroPorta: json['numero_porta'],
      freguesia: json['freguesia'],
      localidade: json['localidade'],
      complemento: json['complemento'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_morada': idMorada,
      'codigo_postal': codigoPostal,
      'rua': rua,
      'numero_porta': numeroPorta,
      'freguesia': freguesia,
      'localidade': localidade,
      'complemento': complemento,
    };
  }
}
