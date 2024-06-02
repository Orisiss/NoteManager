/// Classe représentant une évaluation de récompense.
class RecompenseEvaluation {
  final int? id;
  final int idRecompense;
  final int idEvaluation;
  final DateTime dateObtention;

  /// Constructeur de la classe RecompenseEvaluation.
  ///
  /// [id] est l'identifiant de l'évaluation de récompense.
  /// [idRecompense] est l'identifiant de la récompense associée à l'évaluation.
  /// [idEvaluation] est l'identifiant de l'évaluation associée à la récompense.
  /// [dateObtention] est la date d'obtention de la récompense.
  RecompenseEvaluation({
    required this.id,
    required this.idRecompense,
    required this.idEvaluation,
    required this.dateObtention,
  });

  /// Convertit l'objet RecompenseEvaluation en un Map.
  ///
  /// Retourne un Map contenant les propriétés de l'objet RecompenseEvaluation.
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'idRecompense': idRecompense,
      'idEvaluation': idEvaluation,
      'dateObtention': dateObtention.toIso8601String(),
    };
  }
}