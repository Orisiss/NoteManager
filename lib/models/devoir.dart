class Devoir {
  static final List<String> values = [
    'id',
    'titre',
    'description',
    'date_echeance',
    'priorite',
    'fait',
    'id_matiere',
  ];

  static const String id = 'id';
  static const String titre = 'titre';
  static const String description = 'description';
  static const String dateEcheance = 'date_echeance';
  static const String priorite = 'priorite';
  static const String fait = 'fait';
  static const String idMatiere = 'id_matiere';

  final int idDevoir;
  final String titreDevoir;
  final String descriptionDevoir;
  final int dateEcheanceDevoir;
  final int prioriteDevoir;
  final int faitDevoir;
  final int idMatiereDevoir;

  Devoir({
    required this.idDevoir,
    required this.titreDevoir,
    required this.descriptionDevoir,
    required this.dateEcheanceDevoir,
    required this.prioriteDevoir,
    required this.faitDevoir,
    required this.idMatiereDevoir,
  });

  Devoir.fromMap(Map<String, dynamic> map)
      : idDevoir = map[id],
        titreDevoir = map[titre],
        descriptionDevoir = map[description],
        dateEcheanceDevoir = map[dateEcheance],
        prioriteDevoir = map[priorite],
        faitDevoir = map[fait],
        idMatiereDevoir = map[idMatiere];

  Map<String, Object> toMap() {
    return {
      id: idDevoir,
      titre: titreDevoir,
      description: descriptionDevoir,
      dateEcheance: dateEcheanceDevoir,
      priorite: prioriteDevoir,
      fait: faitDevoir,
      idMatiere: idMatiereDevoir,
    };
  }
}
