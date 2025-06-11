class Utilizador {
  int id;
  String nome;
  String email;
  String password;

  Utilizador({
    required this.nome,
    required this.email,
    required this.password,
    required this.id,
  });

  @override
  String toString() {
    return 'Utilizador(nome: $nome, email: $email, password: $password)';
  }


  Utilizador.fromJson(Map<String, dynamic> json)
      : id = json['id_utilizador'],
        nome = json['Nome'],
        email = json['Email'],
        password = json['palavra_passe'];
}

  