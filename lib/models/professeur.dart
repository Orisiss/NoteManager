class Professeur {
  final int? id;
  final Genre genre;
  final String nom;

  Professeur({
    this.id,
    required this.genre,
    required this.nom,
  });

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

enum Genre {Mr, Mme, Mlle}
