class Morada {
  int idMorada;
  String codigoPostal;
  String rua;
  int numeroPorta;
  String freguesia;
  String localidade;
  String complemento;
  List<dynamic> localizacao; // Substitua por uma classe Localizacao se existir

  Morada({
    required this.idMorada,
    required this.codigoPostal,
    required this.rua,
    required this.numeroPorta,
    required this.freguesia,
    required this.localidade,
    required this.complemento,
    required this.localizacao,
  });

  factory Morada.fromJson(Map<String, dynamic> json) {
    return Morada(
      idMorada: json['id_morada'],
      codigoPostal: json['codigo_postal'],
      rua: json['Rua'],
      numeroPorta: json['numero_porta'],
      freguesia: json['freguesia'],
      localidade: json['Localidade'],
      complemento: json['Complemento'],
      localizacao: json['Localizacao'] ?? [],
    );
  }
    @override
  String toString() {
    return 'Morada(idMorada: $idMorada, codigoPostal: $codigoPostal, rua: $rua, numeroPorta: $numeroPorta, freguesia: $freguesia, localidade: $localidade, complemento: $complemento, localizacao: $localizacao)';
  }
}


