class MatiereColumn {
  static const String id = 'id';
  static const String nom = 'nom';

  final int? idMatiere;
  final String nomMatiere;

  MatiereColumn({
    this.idMatiere,
    required this.nomMatiere
  });

  Map<String, Object?> toMap() {
    return {
      'id': idMatiere,
      'nom': nomMatiere,
    };
  }

  @override
  String toString() {
    return 'Matiere{id: $idMatiere, nom: $nomMatiere}';
  }
}