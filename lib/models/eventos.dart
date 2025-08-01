class Evento {
  final int idEvento;
  final String titulo;
  final String descricao;
  final String localizacao;
  final DateTime dataInicio;
  final DateTime dataFim;
  final double mediaAvaliacoes;
  final int? limiteInscricoes;
  final String categoria;
  final String nomeOrador;
  double preco;

  Evento({
    required this.idEvento,
    required this.titulo,
    required this.descricao,
    required this.localizacao,
    required this.dataInicio,
    required this.dataFim,
    required this.mediaAvaliacoes,
    this.limiteInscricoes,
    required this.categoria,
    required this.nomeOrador,
    required this.preco,
  });

  factory Evento.fromJson(Map<String, dynamic> json) {
    return Evento(
      idEvento: json['id_evento'],
      titulo: json['titulo'],
      descricao: json['descricao'],
      localizacao: (json['localizacao'] ?? 'Sem Localização') as String,
      dataInicio: DateTime.parse(json['data_inicio']),
      dataFim: DateTime.parse(json['data_fim']),
      mediaAvaliacoes: (json['media_avaliacoes'] ?? 0).toDouble(),
      limiteInscricoes: json['limite_inscricoes'],
      categoria: (json['categoria'] ?? 'Sem Categoria') as String,
      nomeOrador: (json['nome_orador'] ?? 'Sem Orador') as String,
      preco: (json['preco'] ?? 0).toDouble(),
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id_evento': idEvento,
      'titulo': titulo,
      'descricao': descricao,
      'localizacao': localizacao,
      'data_inicio': dataInicio.toIso8601String(),
      'data_fim': dataFim.toIso8601String(),
      'media_avaliacoes': mediaAvaliacoes,
      'limite_inscricoes': limiteInscricoes,
      'categoria': categoria,
      'nome_orador': nomeOrador,
      'preco': preco,
    };
  }
}
