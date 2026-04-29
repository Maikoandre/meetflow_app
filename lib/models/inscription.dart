class Inscription {
  final int id;
  final int evento;
  final int participante;
  final String status;

  Inscription({
    required this.id,
    required this.evento,
    required this.participante,
    required this.status,
  });

  factory Inscription.fromJson(Map<String, dynamic> json) {
    return Inscription(
      id: json['id'],
      evento: json['evento'] ?? 0,
      participante: json['participante'] ?? 0,
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'evento': evento,
      'participante': participante,
      'status': status,
    };
  }
}
