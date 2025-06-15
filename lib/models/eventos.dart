class Evento {
  final int idEvento;
  final String titulo;
  final String descricao;
  final DateTime dataInicio;
  final DateTime dataFim;
  final double mediaAvaliacoes;
  final int? limiteInscricoes;
  final int idCategoria;
  final String nomeOrador;
  double preco;

  Evento({
    required this.idEvento,
    required this.titulo,
    required this.descricao,
    required this.dataInicio,
    required this.dataFim,
    required this.mediaAvaliacoes,
    this.limiteInscricoes,
    required this.idCategoria,
    required this.nomeOrador,
    required this.preco,
  });

  factory Evento.fromJson(Map<String, dynamic> json) {
    return Evento(
      idEvento: json['id_evento'],
      titulo: json['titulo'],
      descricao: json['descricao'],
      dataInicio: DateTime.parse(json['data_inicio']),
      dataFim: DateTime.parse(json['data_fim']),
      mediaAvaliacoes: (json['media_avaliacoes'] ?? 0).toDouble(),
      limiteInscricoes: json['limite_inscricoes'],
      idCategoria: json['id_categoria'],
      nomeOrador: json['nome_orador'],
      preco: (json['preco'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_evento': idEvento,
      'titulo': titulo,
      'descricao': descricao,
      'data_inicio': dataInicio.toIso8601String(),
      'data_fim': dataFim.toIso8601String(),
      'media_avaliacoes': mediaAvaliacoes,
      'limite_inscricoes': limiteInscricoes,
      'id_categoria': idCategoria,
      'nome_orador': nomeOrador,
      'preco': preco,
    };
  }
}
