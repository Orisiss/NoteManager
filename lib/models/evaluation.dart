class Evaluation {
  static final List<String> values = [
    'id',
    'valeur',
    'date',
    'id_matiere',
  ];

  static const String id = 'id';
  static const String title = 'title';
  static const String valeur = 'valeur';
  static const String date = 'date';
  static const String id_matiere = 'id_matiere';

  final int idEvaluation;
  final String titleEvaluation;
  final int valeurEvaluation;
  final int dateEvaluation;
  final int idMatiereEvaluation;

  Evaluation({
    required this.idEvaluation,
    required this.titleEvaluation,
    required this.valeurEvaluation,
    required this.dateEvaluation,
    required this.idMatiereEvaluation,
  });

  Evaluation.fromMap(Map<String, dynamic> map)
      : idEvaluation = map[id],
        titleEvaluation = map[title],
        valeurEvaluation = map[valeur],
        dateEvaluation = map[date],
        idMatiereEvaluation = map[id_matiere];

  Map<String, Object> toMap() {
    return {
      id: idEvaluation,
      title: titleEvaluation,
      valeur: valeurEvaluation,
      date: dateEvaluation,
      id_matiere: idMatiereEvaluation,
    };
  }
}
