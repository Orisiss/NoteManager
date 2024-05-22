class Evaluation {
  final int? id;
  final String titre;
  final int valeur;
  final int coef;
  final DateTime date;
  final int idMatiere;

  Evaluation({
    this.id,
    required this.titre,
    required this.valeur,
    required this.coef,
    required this.date,
    required this.idMatiere,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'titre': titre,
      'valeur': valeur,
      'coef': coef,
      'date': date.toIso8601String(),
      'idMatiere': idMatiere,
    };
  }
}
