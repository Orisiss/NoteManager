class MatiereColumn {
  static final List<String> values = [
    'id',
    'nom',
    'id_professeur'
  ];

  static const String id = 'id';
  static const String nom = 'nom';
  static const String id_professeur = 'id_professeur';

  final int idMatiere;
  final int nomMatiere;
  final int idProfesseurMatiere;

  MatiereColumn({
    required this.idMatiere,
    required this.nomMatiere,
    required this.idProfesseurMatiere,
  });

  MatiereColumn.fromMap(Map<String, dynamic> map)
      : idMatiere = map[id],
        nomMatiere = map[nom],
        idProfesseurMatiere = map[id_professeur];

  Map<String, Object> toMap() {
    return {
      id: idMatiere,
      nom: nomMatiere,
      id_professeur: idProfesseurMatiere,
    };
  }
}