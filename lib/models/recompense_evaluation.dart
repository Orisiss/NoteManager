class RecompenseEvaluation {
  final int? id;
  final int idRecompense;
  final int idEvaluation;
  final DateTime dateObtention;

  RecompenseEvaluation({
    required this.id,
    required this.idRecompense,
    required this.idEvaluation,
    required this.dateObtention,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'idRecompense': idRecompense,
      'idEvaluation': idEvaluation,
      'dateObtention': dateObtention.toIso8601String(),
    };
  }
}