class Devoir {
  final int? id;
  final String titre;
  final String description;
  final DateTime dateEcheance;
  final Priorite priorite;
  final int idMatiere;
  final int idProfesseur;

  Devoir({
    this.id,
    required this.titre,
    required this.description,
    required this.dateEcheance,
    required this.priorite,
    required this.idMatiere,
    required this.idProfesseur,
  });

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

enum Priorite { Faible, Moyen, Eleve, Urgent }