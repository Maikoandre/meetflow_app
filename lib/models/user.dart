class UserProfile {
  final int id;
  final String nome;
  final int idade;
  final String tipo;
  final int user;

  UserProfile({
    required this.id,
    required this.nome,
    required this.idade,
    required this.tipo,
    required this.user,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      nome: json['nome'] ?? '',
      idade: json['idade'] ?? 0,
      tipo: json['tipo'] ?? '',
      user: json['user'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'idade': idade,
      'tipo': tipo,
      'user': user,
    };
  }
}
