class Evento {
  int idEvento;
  String titulo;
  String descricao;
  DateTime dataInicio;
  DateTime dataFim;
  int idOrganizador;
  int idCategoria;
  int idLocalizacao;
  int idOrador;

  // Pode criar classes para estes se quiser detalhar mais
  dynamic organizador;
  dynamic categoria;
  dynamic localizacao;
  dynamic orador;
  List<dynamic> inscricao;

  Evento({
    required this.idEvento,
    required this.titulo,
    required this.descricao,
    required this.dataInicio,
    required this.dataFim,
    required this.idOrganizador,
    required this.idCategoria,
    required this.idLocalizacao,
    required this.idOrador,
    this.organizador,
    this.categoria,
    this.localizacao,
    this.orador,
    required this.inscricao,
  });

  factory Evento.fromJson(Map<String, dynamic> json) {
    return Evento(
      idEvento: json['id_evento'],
      titulo: json['Titulo'],
      descricao: json['Descricao'],
      dataInicio: DateTime.parse(json['data_inicio']),
      dataFim: DateTime.parse(json['data_fim']),
      idOrganizador: json['id_organizador'],
      idCategoria: json['id_categoria'],
      idLocalizacao: json['id_localizacao'],
      idOrador: json['id_orador'],
      organizador: json['Organizador'],
      categoria: json['Categoria'],
      localizacao: json['Localizacao'],
      orador: json['Orador'],
      inscricao: json['Inscricao'] ?? [],
    );
  }

  @override
  String toString() {
    return 'Evento(idEvento: $idEvento, titulo: $titulo, descricao: $descricao, dataInicio: $dataInicio, dataFim: $dataFim, idOrganizador: $idOrganizador, idCategoria: $idCategoria, idLocalizacao: $idLocalizacao, idOrador: $idOrador, organizador: $organizador, categoria: $categoria, localizacao: $localizacao, orador: $orador, inscricao: $inscricao)';
  }
}