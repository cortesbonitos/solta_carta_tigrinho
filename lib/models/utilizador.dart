class Utilizador {
  final int idUtilizador;
  final String nome;
  final String email;
  final String palavraPasse;
  final int idTipoUtilizador;

  static Map<int, Utilizador> utilizadores = {};
  static Utilizador? currentUser;

  Utilizador({
    required this.idUtilizador,
    required this.nome,
    required this.email,
    required this.palavraPasse,
    required this.idTipoUtilizador,
  });

  factory Utilizador.fromJson(Map<String, dynamic> json) {
    return Utilizador(
      idUtilizador: json['id_utilizador'],
      nome: json['nome'],
      email: json['email'],
      palavraPasse: json['palavra_passe'],
      idTipoUtilizador: json['id_tipo_utilizador'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_utilizador': idUtilizador,
      'nome': nome,
      'email': email,
      'palavra_passe': palavraPasse,
      'id_tipo_utilizador': idTipoUtilizador,
    };
  }
}
