/// Représente une évaluation.
class Evaluation {
  int? id;
  final String titre;
  final int valeur;
  final int coef;
  final DateTime date;
  final int idMatiere;

  /// Constructeur de la classe [Evaluation].
  ///
  /// [id] : L'identifiant de l'évaluation.
  /// [titre] : Le titre de l'évaluation.
  /// [valeur] : La valeur de l'évaluation.
  /// [coef] : Le coefficient de l'évaluation.
  /// [date] : La date de l'évaluation.
  /// [idMatiere] : L'identifiant de la matière associée à l'évaluation.
  Evaluation({
    this.id,
    required this.titre,
    required this.valeur,
    required this.coef,
    required this.date,
    required this.idMatiere,
  });

  /// Convertit l'objet [Evaluation] en un [Map] de clés/valeurs.
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
