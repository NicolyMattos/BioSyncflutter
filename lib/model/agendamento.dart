class Agendamento {
  final String data;      // String simples (ex: "12/12/2025")
  final String coletor;
  final String material;
  final String status;

  Agendamento({
    required this.data,
    required this.coletor,
    required this.material,
    this.status = 'Agendado',
  });
}