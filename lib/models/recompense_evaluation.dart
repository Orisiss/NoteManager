class RecompenseEvaluationColumn {
  static final List<String> values = [
    'id',
    'id_recompense',
    'id_evaluation',
    'date_obtention'
  ];

  static const String id = 'id';
  static const String idRecompense = 'id_recompense';
  static const String idEvaluation = 'id_evaluation';
  static const String dateObtention = 'date_obtention';

  final int idRecompenseEvaluation;
  final int idRecompenseRecompenseEvaluation;
  final int idEvaluationRecompenseEvaluation;
  final int dateObtentionRecompenseEvaluation;

  RecompenseEvaluationColumn({
    required this.idRecompenseEvaluation,
    required this.idRecompenseRecompenseEvaluation,
    required this.idEvaluationRecompenseEvaluation,
    required this.dateObtentionRecompenseEvaluation,
  });

  RecompenseEvaluationColumn.fromMap(Map<String, dynamic> map)
      : idRecompenseEvaluation = map[id],
        idRecompenseRecompenseEvaluation = map[idRecompense],
        idEvaluationRecompenseEvaluation = map[idEvaluation],
        dateObtentionRecompenseEvaluation = map[dateObtention];

  Map<String, Object> toMap() {
    return {
      id: idRecompenseEvaluation,
      idRecompense: idRecompenseRecompenseEvaluation,
      idEvaluation: idEvaluationRecompenseEvaluation,
      dateObtention: dateObtentionRecompenseEvaluation,
    };
  }
}