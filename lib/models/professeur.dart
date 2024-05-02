class Professeur {
  final int? idProfesseur;
  final Genre genreProfesseur;
  final String nomProfesseur;

  Professeur({
    this.idProfesseur,
    required this.genreProfesseur,
    required this.nomProfesseur,
  });

  Map<String, Object?> toMap() {
    return {
      'id': idProfesseur,
      'genre': genreProfesseur.index,
      'nom': nomProfesseur,
    };
  }

  @override
  String toString() {
    return '$genreProfesseur. $nomProfesseur';
  }
}

enum Genre {Mr, Mme, Mlle}
