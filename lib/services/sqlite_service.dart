import 'package:note_manager/models/devoir.dart';
import 'package:note_manager/models/evaluation.dart';
import 'package:note_manager/models/matiere.dart';
import 'package:note_manager/models/professeur.dart';
import 'package:note_manager/models/recompense.dart';
import 'package:note_manager/models/recompense_evaluation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// Service de gestion de la base de données SQLite pour l'application Note Manager.
class SqliteService {
  /// Initialise la base de données.
  ///
  /// Retourne une instance de la base de données.
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();

    return openDatabase(join(path, 'note_manager.db'),
        onCreate: (database, version) async {
      await database.execute('''
        CREATE TABLE Devoir (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titre TEXT NOT NULL,
        description TEXT NOT NULL,
        date_echeance INTEGER NOT NULL,
        priorite INTEGER NOT NULL,
        idMatiere INTEGER NOT NULL,
        idProfesseur INTEGER NOT NULL,
        FOREIGN KEY (idMatiere) REFERENCES Matiere(id),
        FOREIGN KEY (idProfesseur) REFERENCES Professeur(id)
        );
      ''');

      await database.execute('''
        CREATE TABLE Matiere (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nom TEXT NOT NULL
        );
      ''');

      await database.execute('''
        CREATE TABLE Evaluation (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titre TEXT NOT NULL,
        valeur INTEGER NOT NULL,
        coef INTEGER NOT NULL,
        date DATETIME NOT NULL,
        idMatiere INTEGER NOT NULL,
        FOREIGN KEY (idMatiere) REFERENCES Matiere(id)
        );
      ''');

      await database.execute('''
        CREATE TABLE Professeur (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        genre INTEGER NOT NULL,
        nom TEXT NOT NULL
        );
      ''');

      await database.execute('''
        CREATE TABLE Recompense (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nom TEXT NOT NULL,
        points_requis INTEGER NOT NULL,
        isObtained BOOL NOT NULL
        );
      ''');

      await database.execute('''
        CREATE TABLE RecompenseEvaluation (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        idEvaluation INTEGER NOT NULL,
        idRecompense INTEGER NOT NULL,
        dateObtention DATETIME NOT NULL,
        FOREIGN KEY (idEvaluation) REFERENCES Devoir(id),
        FOREIGN KEY (idRecompense) REFERENCES Recompense(id)
        );
      ''');
    }, version: 1);
  }

  /// Insère un [Devoir] dans la base de données.
  ///
  /// Retourne l'ID du [Devoir] inséré.
  Future<int> insertDevoir(Devoir devoir) async {
    Database db = await initializeDB();
    return await db.insert('Devoir', devoir.toMap());
  }

  /// Récupère tous les [Devoir]s de la base de données.
  ///
  /// Retourne une liste de [Devoir]s.
  Future<List<Devoir>> getAllDevoirs() async {
    final db = await initializeDB();
    final List<Map<String, Object?>> devoirsMaps = await db.query('Devoir');
    return [
      for (final map in devoirsMaps)
        Devoir(
          id: map['id'] as int,
          titre: map['titre'] as String,
          description: map['description'] as String,
          dateEcheance: DateTime.parse(map['date_echeance'].toString()),
          priorite: Priorite.values[map['priorite'] as int],
          idProfesseur: int.parse(map['idProfesseur'].toString()),
          idMatiere: int.parse(map['idMatiere'].toString()),
        ),
    ];
  }

  /// Met à jour un [Devoir] dans la base de données.
  ///
  /// Retourne le nombre de [Devoir]s mis à jour.
  Future<int> updateDevoir(Devoir devoir) async {
    Database db = await initializeDB();
    return await db.update('Devoir', devoir.toMap(),
        where: 'id = ?', whereArgs: [devoir.id]);
  }

  /// Supprime un [Devoir] de la base de données.
  ///
  /// Retourne le nombre de [Devoir]s supprimés.
  Future<int> deleteDevoir(int id) async {
    Database db = await initializeDB();
    return await db.delete('Devoir', where: 'id =?', whereArgs: [id]);
  }

  /// Insère une [Matiere] dans la base de données.
  ///
  /// Retourne l'ID de la [Matiere] insérée.
  Future<int> insertMatiere(Matiere matiere) async {
    Database db = await initializeDB();
    return await db.insert('Matiere', matiere.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  /// Récupère toutes les [Matiere]s de la base de données.
  ///
  /// Retourne une liste de [Matiere]s.
  Future<List<Matiere>> getAllMatieres() async {
    final db = await initializeDB();
    final List<Map<String, Object?>> matiereMaps = await db.query('Matiere');
    return [
      for (final {
            'id': id as int,
            'nom': nom as String,
          } in matiereMaps)
        Matiere(
          id: id,
          nom: nom,
        ),
    ];
  }

  /// Met à jour une [Matiere] dans la base de données.
  ///
  /// Retourne le nombre de [Matiere]s mises à jour.
  Future<int> updateMatiere(Matiere matiere) async {
    Database db = await initializeDB();
    return await db.update('Matiere', matiere.toMap(),
        where: 'id = ?', whereArgs: [matiere.id]);
  }

  /// Supprime une [Matiere] de la base de données.
  ///
  /// Retourne le nombre de [Matiere]s supprimées.
  Future<int> deleteMatiere(int id) async {
    Database db = await initializeDB();
    return await db.delete('Matiere', where: 'id =?', whereArgs: [id]);
  }

  /// Insère un [Professeur] dans la base de données.
  ///
  /// Retourne l'ID du [Professeur] inséré.
  Future<int> insertProfesseur(Professeur professeur) async {
    Database db = await initializeDB();
    return await db.insert('Professeur', professeur.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  /// Récupère tous les [Professeur]s de la base de données.
  ///
  /// Retourne une liste de [Professeur]s.
  Future<List<Professeur>> getAllProfesseurs() async {
    final db = await initializeDB();
    final List<Map<String, Object?>> professeursMaps =
        await db.query('Professeur');
    return [
      for (final map in professeursMaps)
        Professeur(
          id: map['id'] as int,
          genre: Genre.values[map['genre'] as int],
          nom: map['nom'] as String,
        ),
    ];
  }

  /// Met à jour un [Professeur] dans la base de données.
  ///
  /// Retourne le nombre de [Professeur]s mis à jour.
  Future<int> updateProfesseur(Professeur professeur) async {
    Database db = await initializeDB();
    return await db.update('Professeur', professeur.toMap(),
        where: 'id = ?', whereArgs: [professeur.id]);
  }

  /// Supprime un [Professeur] de la base de données.
  ///
  /// Retourne le nombre de [Professeur]s supprimés.
  Future<int> deleteProfesseur(int id) async {
    Database db = await initializeDB();
    return await db.delete('Professeur', where: 'id = ?', whereArgs: [id]);
  }

  /// Insère une [Evaluation] dans la base de données.
  ///
  /// Retourne l'ID de l'[Evaluation] insérée.
  Future<int> insertEvaluation(Evaluation evaluation) async {
    Database db = await initializeDB();
    int id = await db.insert('Evaluation', evaluation.toMap());
    List<Evaluation> allEvaluations = await getAllEvaluations();
    int totalPoints =
        allEvaluations.fold(0, (sum, e) => sum + e.valeur * e.coef);
    List<Recompense> allRecompenses = await getAllRecompenses();
    for (Recompense recompense in allRecompenses) {
      if (totalPoints >= recompense.points_requis) {
        recompense.isObtained = true;
        await updateRecompense(recompense);
        RecompenseEvaluation recompenseEvaluation = RecompenseEvaluation(
          id: null,
          idRecompense: recompense.id!,
          idEvaluation: id,
          dateObtention: evaluation.date,
        );
        await insertRecompenseEvaluation(recompenseEvaluation);
      }
    }
    return id;
  }

  /// Récupère toutes les [Evaluation]s de la base de données.
  ///
  /// Retourne une liste d'[Evaluation]s.
  Future<List<Evaluation>> getAllEvaluations() async {
    final db = await initializeDB();
    final List<Map<String, Object?>> evaluationsMaps =
        await db.query('Evaluation');
    return [
      for (final map in evaluationsMaps)
        Evaluation(
          id: map['id'] as int,
          titre: map['titre'] as String,
          valeur: map['valeur'] as int,
          coef: map['coef'] as int,
          date: DateTime.parse(map['date'].toString()),
          idMatiere: int.parse(map['idMatiere'].toString()),
        ),
    ];
  }

  /// Met à jour une [Evaluation] dans la base de données.
  ///
  /// Retourne le nombre d'[Evaluation]s mises à jour.
  Future<int> updateEvaluation(Evaluation evaluation) async {
    Database db = await initializeDB();
    return await db.update('Evaluation', evaluation.toMap(),
        where: 'id = ?', whereArgs: [evaluation.id]);
  }

  /// Supprime une [Evaluation] de la base de données.
  ///
  /// Retourne le nombre d'[Evaluation]s supprimées.
  Future<int> deleteEvaluation(int id) async {
    Database db = await initializeDB();
    return await db.delete('Evaluation', where: 'id = ?', whereArgs: [id]);
  }

  /// Insère une [Recompense] dans la base de données.
  ///
  /// Retourne l'ID de la [Recompense] insérée.
  Future<int> insertRecompense(Recompense recompense) async {
    Database db = await initializeDB();
    return await db.insert('Recompense', recompense.toMap());
  }

  /// Récupère toutes les [Recompense]s de la base de données.
  ///
  /// Retourne une liste de [Recompense]s.
  Future<List<Recompense>> getAllRecompenses() async {
    Database db = await initializeDB();
    List<Map<String, Object?>> recompensesMaps = await db.query('Recompense');
    return [
      for (final map in recompensesMaps)
        Recompense(
            id: map['id'] as int,
            points_requis: map['points_requis'] as int,
            nom: map['nom'] as String,
            isObtained: (map['isObtained'] as int) == 1 ? true : false)
    ];
  }

  /// Met à jour une [Recompense] dans la base de données.
  ///
  /// Retourne le nombre de [Recompense]s mises à jour.
  Future<int> updateRecompense(Recompense recompense) async {
    Database db = await initializeDB();
    return await db.update('Recompense', recompense.toMap(),
        where: 'id = ?', whereArgs: [recompense.id]);
  }

  /// Supprime une [Recompense] de la base de données.
  ///
  /// Retourne le nombre de [Recompense]s supprimées.
  Future<int> deleteRecompense(int id) async {
    Database db = await initializeDB();
    return await db.delete('Recompense', where: 'id = ?', whereArgs: [id]);
  }

  /// Insère une [RecompenseEvaluation] dans la base de données.
  ///
  /// Retourne l'ID de la [RecompenseEvaluation] insérée.
  Future<int> insertRecompenseEvaluation(
      RecompenseEvaluation recompenseEvaluation) async {
    Database db = await initializeDB();
    return await db.insert(
        'RecompenseEvaluation', recompenseEvaluation.toMap());
  }

  /// Récupère toutes les [RecompenseEvaluation]s de la base de données.
  ///
  /// Retourne une liste de [RecompenseEvaluation]s.
  Future<List<RecompenseEvaluation>> getAllRecompenseEvaluation() async {
    Database db = await initializeDB();
    List<Map<String, Object?>> recompenseEvaluationsMaps =
        await db.query('RecompenseEvaluation');
    return [
      for (final map in recompenseEvaluationsMaps)
        RecompenseEvaluation(
          id: map['id'] as int,
          idRecompense: map['idRecompense'] as int,
          idEvaluation: map['idEvaluation'] as int,
          dateObtention: DateTime.parse(map['dateObtention'].toString()),
        )
    ];
  }

  /// Met à jour une [RecompenseEvaluation] dans la base de données.
  ///
  /// Retourne le nombre de [RecompenseEvaluation]s mises à jour.
  Future<int> updateRecompenseEvaluation(
      RecompenseEvaluation recompenseEvaluation) async {
    Database db = await initializeDB();
    return await db.update('RecompenseEvaluation', recompenseEvaluation.toMap(),
        where: 'id = ?', whereArgs: [recompenseEvaluation.id]);
  }

  /// Supprime une [RecompenseEvaluation] de la base de données.
  ///
  /// Retourne le nombre de [RecompenseEvaluation]s supprimées.
  Future<int> deleteRecompenseEvaluation(int id) async {
    Database db = await initializeDB();
    return await db
        .delete('RecompenseEvaluation', where: 'id = ?', whereArgs: [id]);
  }

  /// Initialise les récompenses.
  ///
  /// Cette fonction initialise les récompenses en vérifiant d'abord si des récompenses existent déjà.
  /// Si aucune récompense n'existe, des récompenses par défaut sont créées et insérées dans la base de données.
  /// Les récompenses par défaut comprennent des objets de type [Recompense] avec des valeurs prédéfinies.
  /// Chaque récompense est insérée individuellement en utilisant la fonction [insertRecompense].
  Future<void> initializeRewards() async {
    List<Recompense> existingRewards = await getAllRecompenses();
    if (existingRewards.isEmpty) {
      List<Recompense> defaultRewards = [
        Recompense(
            id: 1, points_requis: 100, nom: 'Recompense 1', isObtained: false),
        Recompense(
            id: 2, points_requis: 200, nom: 'Recompense 2', isObtained: false),
        Recompense(
            id: 3, points_requis: 300, nom: 'Recompense 3', isObtained: false),
        Recompense(
            id: 4, points_requis: 400, nom: 'Recompense 4', isObtained: false),
        Recompense(
            id: 5, points_requis: 500, nom: 'Recompense 5', isObtained: false),
      ];
      for (Recompense reward in defaultRewards) {
        await insertRecompense(reward);
      }
    }
  }
}
