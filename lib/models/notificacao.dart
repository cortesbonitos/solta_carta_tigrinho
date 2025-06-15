class Notificacao {
  final int idNotificacao;
  final String mensagem;
  final String dataEnvio;
  final int idUtilizador;
  final int idEvento;

  Notificacao({
    required this.idNotificacao,
    required this.mensagem,
    required this.dataEnvio,
    required this.idUtilizador,
    required this.idEvento,
  });

  factory Notificacao.fromJson(Map<String, dynamic> json) {
    return Notificacao(
      idNotificacao: json['id_notificacao'],
      mensagem: json['mensagem'] ?? '',
      dataEnvio: json['data_envio'],
      idUtilizador: json['id_utilizador'],
      idEvento: json['id_evento'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_notificacao': idNotificacao,
      'mensagem': mensagem,
      'data_envio': dataEnvio,
      'id_utilizador': idUtilizador,
      'id_evento': idEvento,
    };
  }
}
