/// Classe représentant une matière.
class Matiere {
  final int? id;
  final String nom;

  /// Constructeur de la classe Matiere.
  ///
  /// Le paramètre [id] est optionnel et représente l'identifiant de la matière.
  /// Le paramètre [nom] est requis et représente le nom de la matière.
  Matiere({
    this.id,
    required this.nom,
  });

  /// Convertit l'objet Matiere en un [Map] de clés/valeurs.
  ///
  /// Retourne un [Map] contenant les clés 'id' et 'nom' avec leurs valeurs respectives.
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'nom': nom,
    };
  }

  @override
  String toString() {
    return 'Matiere{id: $id, nom: $nom}';
  }
}