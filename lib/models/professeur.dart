/// Classe représentant un professeur.
class Professeur {
  final int? id;
  final Genre genre;
  final String nom;

  /// Constructeur de la classe Professeur.
  ///
  /// Le paramètre [id] est optionnel et représente l'identifiant du professeur.
  /// Le paramètre [genre] est requis et représente le genre du professeur.
  /// Le paramètre [nom] est requis et représente le nom du professeur.
  Professeur({
    this.id,
    required this.genre,
    required this.nom,
  });

  /// Convertit l'objet Professeur en un [Map] de clés/valeurs.
  ///
  /// Retourne un [Map] contenant les propriétés de l'objet Professeur.
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'genre': genre.index,
      'nom': nom,
    };
  }

  @override
  String toString() {
    return '$genre. $nom';
  }
}

/// Enumération représentant le genre d'un professeur.
enum Genre {Mr, Mme, Mlle}
