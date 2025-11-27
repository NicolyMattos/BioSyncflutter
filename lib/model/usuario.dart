class Usuario {
  final String nome;
  final String email;
  final String senha;
  final String tipo; // 'Morador' ou 'Coletor'

  Usuario({
    required this.nome,
    required this.email,
    required this.senha,
    required this.tipo,
  });
}