class Bilhete {
  final int? idBilhete;
  final int idInscricao;
  final int idEvento;
  final String qrCode;

  Bilhete({
    this.idBilhete,
    required this.idInscricao,
    required this.idEvento,
    required this.qrCode,
  });

  factory Bilhete.fromJson(Map<String, dynamic> json) {
    return Bilhete(
      idBilhete: json['id_bilhete'],
      idInscricao: json['id_inscricao'],
      idEvento: json['id_evento'],
      qrCode: json['qr_code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_bilhete': idBilhete,
      'id_inscricao': idInscricao,
      'id_evento': idEvento,
      'qr_code': qrCode,
    };
  }
}

