class ProfesseurColumn {
  final int? idProfesseur;
  final String prenomProfesseur;
  final String nomProfesseur;

  ProfesseurColumn({
    this.idProfesseur,
    required this.prenomProfesseur,
    required this.nomProfesseur,
  });

  Map<String, Object?> toMap() {
    return {
      'id': idProfesseur,
      'prenom': prenomProfesseur,
      'nom': nomProfesseur,
    };
  }

  @override
  String toString() {
    return 'Professeur{id: $idProfesseur, prenom: $prenomProfesseur, nom: $nomProfesseur}';
  }
}
