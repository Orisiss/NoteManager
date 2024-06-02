/// Classe représentant une récompense.
class Recompense {
  final int? id;
  final int points_requis;
  final String nom;
  bool isObtained;

  /// Constructeur de la classe Recompense.
  ///
  /// [id] est l'identifiant de la récompense.
  /// [points_requis] est le nombre de points requis pour obtenir la récompense.
  /// [nom] est le nom de la récompense.
  /// [isObtained] indique si la récompense a été obtenue ou non.
  Recompense({
    this.id,
    required this.points_requis,
    required this.nom, 
    this.isObtained = false,
  });

  /// Convertit la récompense en un [Map] de clés/valeurs.
  ///
  /// Retourne un [Map] contenant les propriétés de la récompense.
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'points_requis': points_requis,
      'nom': nom,
      'isObtained': isObtained ? 1 : 0,
    };
  }
}