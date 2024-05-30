class Recompense {
  final int? id;
  final int points_requis;
  final String nom;
  bool isObtained;

  Recompense({
    this.id,
    required this.points_requis,
    required this.nom, 
    this.isObtained = false,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'points_requis': points_requis,
      'nom': nom,
      'isObtained': isObtained ? 1 : 0,
    };
  }
}