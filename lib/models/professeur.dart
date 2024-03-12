class ProfesseurColumn {
  static final List<String> values = [
    'id',
    'prenom',
    'nom',
  ];

  static const String id = 'id';
  static const String prenom = 'prenom';
  static const String nom = 'nom';

  final int idProfesseur;
  final String prenomProfesseur;
  final String nomProfesseur;

  ProfesseurColumn({
    required this.idProfesseur,
    required this.prenomProfesseur,
    required this.nomProfesseur,
  });

  ProfesseurColumn.fromMap(Map<String, dynamic> map)
      : idProfesseur = map[id],
        prenomProfesseur = map[prenom],
        nomProfesseur = map[nom];

  Map<String, Object> toMap() {
    return {
      id: idProfesseur,
      prenom: prenomProfesseur,
      nom: nomProfesseur,
    };
  }
}
