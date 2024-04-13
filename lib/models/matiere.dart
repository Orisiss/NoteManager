class MatiereColumn {
  static final List<String> values = [
    'id',
    'nom'
  ];

  static const String id = 'id';
  static const String nom = 'nom';

  final int idMatiere;
  final String nomMatiere;

  MatiereColumn({
    required this.idMatiere,
    required this.nomMatiere
  });

  MatiereColumn.fromMap(Map<String, dynamic> map)
      : idMatiere = map[id],
        nomMatiere = map[nom];

  Map<String, Object> toMap() {
    return {
      id: idMatiere,
      nom: nomMatiere
    };
  }
}