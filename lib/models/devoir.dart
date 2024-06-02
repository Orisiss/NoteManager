/// Représente un devoir.
class Devoir {
  final int? id;
  final String titre;
  final String description;
  final DateTime dateEcheance;
  final Priorite priorite;
  final int idMatiere;
  final int idProfesseur;

  /// Constructeur de la classe [Devoir].
  ///
  /// [id] : L'identifiant du devoir.
  /// [titre] : Le titre du devoir.
  /// [description] : La description du devoir.
  /// [dateEcheance] : La date d'échéance du devoir.
  /// [priorite] : La priorité du devoir.
  /// [idMatiere] : L'identifiant de la matière associée au devoir.
  /// [idProfesseur] : L'identifiant du professeur associé au devoir.
  Devoir({
    this.id,
    required this.titre,
    required this.description,
    required this.dateEcheance,
    required this.priorite,
    required this.idMatiere,
    required this.idProfesseur,
  });

  /// Convertit l'objet [Devoir] en un [Map] de clés/valeurs.
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'titre': titre,
      'description': description,
      'date_echeance': dateEcheance.toIso8601String(),
      'priorite': priorite.index,
      'idMatiere': idMatiere,
      'idProfesseur': idProfesseur,
    };
  }
}

/// Énumération représentant les différentes priorités d'un devoir.
enum Priorite { Faible, Moyen, Eleve, Urgent }