class Matiere {
  final int? id;
  final String nom;

  Matiere({
    this.id,
    required this.nom
  });

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