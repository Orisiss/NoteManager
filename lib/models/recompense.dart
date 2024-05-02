class Recompense {
  static final List<String> values = [
    'id',
    'nom',
  ];

  static const String id = 'id';
  static const String nom = 'nom';

  final int idRecompense;
  final String nomRecompense;

  Recompense({
    required this.idRecompense,
    required this.nomRecompense,
  });

  Recompense.fromMap(Map<String, dynamic> map)
      : idRecompense = map[id],
        nomRecompense = map[nom];

  Map<String, Object> toMap() {
    return {
      id: idRecompense,
      nom: nomRecompense,
    };
  }
}