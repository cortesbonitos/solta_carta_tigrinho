class Utilizador {
  final int idUtilizador;
  final String nome;
  final String email;
  final String palavraPasse;
  final int idTipoUtilizador;
  final String? tipoUtilizador;

  Utilizador({
    required this.idUtilizador,
    required this.nome,
    required this.email,
    required this.palavraPasse,
    required this.idTipoUtilizador,
    this.tipoUtilizador,
  });

  factory Utilizador.fromJson(Map<String, dynamic> json) {
    return Utilizador(
      idUtilizador: json['id_utilizador'],
      nome: json['nome'],
      email: json['email'],
      palavraPasse: json['palavra_passe'],
      idTipoUtilizador: json['id_tipo_utilizador'],
      tipoUtilizador: json['tipoUtilizador'],
    );
  }

    Map<String, dynamic> toJson() {
    return {
      'id_utilizador': idUtilizador,
      'nome': nome,
      'email': email,
      'palavra_passe': palavraPasse,
      'id_tipo_utilizador': idTipoUtilizador,
      'tipoUtilizador': tipoUtilizador,
    };
  }

  @override
  String toString() {
    return 'Utilizador{idUtilizador: $idUtilizador, nome: $nome, email: $email, palavraPasse: $palavraPasse, idTipoUtilizador: $idTipoUtilizador, tipoUtilizador: $tipoUtilizador}';
  }

   static Utilizador? _currentUser;

  // Getter for the current user
  static Utilizador? get currentUser => _currentUser;

  // Setter for the current user
  static set currentUser(Utilizador? user) {
    _currentUser = user;
  }
}
