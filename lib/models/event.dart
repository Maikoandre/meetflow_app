class Event {
  final int id;
  final String titulo;
  final String descricao;
  final String data;
  final String local;
  final int organizador;
  final bool aprovado;
  final bool publicado;

  Event({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.data,
    required this.local,
    required this.organizador,
    required this.aprovado,
    required this.publicado,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      titulo: json['titulo'] ?? '',
      descricao: json['descricao'] ?? '',
      data: json['data'] ?? '',
      local: json['local'] ?? '',
      organizador: json['organizador'] ?? 0,
      aprovado: json['aprovado'] ?? false,
      publicado: json['publicado'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'data': data,
      'local': local,
      'organizador': organizador,
      'aprovado': aprovado,
      'publicado': publicado,
    };
  }
}
