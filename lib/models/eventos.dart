class Evento {
  final int idEvento;
  final String titulo;
  final String descricao;
  final String dataInicio;
  final String dataFim;
  final double? mediaAvaliacoes;
  final int? limiteInscricoes;
  final int idCategoria;
  final String? nomeOrador;

  Evento({
    required this.idEvento,
    required this.titulo,
    required this.descricao,
    required this.dataInicio,
    required this.dataFim,
    this.mediaAvaliacoes,
    this.limiteInscricoes,
    required this.idCategoria,
    this.nomeOrador,
  });

  factory Evento.fromJson(Map<String, dynamic> json) {
    return Evento(
      idEvento: json['id_evento'],
      titulo: json['titulo'],
      descricao: json['descricao'],
      dataInicio: json['data_inicio'],
      dataFim: json['data_fim'],
      mediaAvaliacoes: json['media_avaliacoes'] != null
          ? json['media_avaliacoes'].toDouble()
          : null,
      limiteInscricoes: json['limite_inscricoes'],
      idCategoria: json['id_categoria'],
      nomeOrador: json['nome_orador'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_evento': idEvento,
      'titulo': titulo,
      'descricao': descricao,
      'data_inicio': dataInicio,
      'data_fim': dataFim,
      'media_avaliacoes': mediaAvaliacoes,
      'limite_inscricoes': limiteInscricoes,
      'id_categoria': idCategoria,
      'nome_orador': nomeOrador,
    };
  }
}
