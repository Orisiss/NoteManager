import 'package:note_manager/models/devoir.dart';
import 'package:note_manager/models/evaluation.dart';
import 'package:note_manager/models/matiere.dart';
import 'package:note_manager/models/professeur.dart';
import 'package:note_manager/models/recompense.dart';
import 'package:note_manager/models/recompense_evaluation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqliteService {
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

  Future<int> insertDevoir(Devoir devoir) async {
    Database db = await initializeDB();
    return await db.insert('Devoir', devoir.toMap());
  }

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

  Future<int> updateDevoir(Devoir devoir) async {
    Database db = await initializeDB();
    return await db.update('Devoir', devoir.toMap(),
        where: 'id = ?', whereArgs: [devoir.id]);
  }

  Future<int> deleteDevoir(int id) async {
    Database db = await initializeDB();
    return await db.delete('Devoir', where: 'id =?', whereArgs: [id]);
  }

  Future<int> insertMatiere(Matiere matiere) async {
    Database db = await initializeDB();
    return await db.insert('Matiere', matiere.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Matiere>> getAllMatieres() async {
    final db = await initializeDB();
    final List<Map<String, Object?>> matiereMaps = await db.query('Matiere');
    return [
      for (final {
            'id': id as int,
            'nom': nom as String,
          } in matiereMaps)
        Matiere(
          idMatiere: id,
          nomMatiere: nom,
        ),
    ];
  }

  Future<int> updateMatiere(Matiere matiere) async {
    Database db = await initializeDB();
    return await db.update('Matiere', matiere.toMap(),
        where: 'id = ?', whereArgs: [matiere.idMatiere]);
  }

  Future<int> deleteMatiere(int id) async {
    Database db = await initializeDB();
    return await db.delete('Matiere', where: 'id =?', whereArgs: [id]);
  }

  Future<int> insertProfesseur(Professeur professeur) async {
    Database db = await initializeDB();
    return await db.insert('Professeur', professeur.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Professeur>> getAllProfesseurs() async {
    final db = await initializeDB();
    final List<Map<String, Object?>> professeurMaps =
        await db.query('Professeur');
    return [
      for (final {
            'id': id as int,
            'genre': genreIndex as int,
            'nom': nomProfesseur as String,
          } in professeurMaps)
        Professeur(
            idProfesseur: id,
            genreProfesseur: Genre.values[genreIndex],
            nomProfesseur: nomProfesseur),
    ];
  }

  Future<int> updateProfesseur(Professeur professeur) async {
    Database db = await initializeDB();
    return await db.update('Professeur', professeur.toMap(),
        where: 'id = ?', whereArgs: [professeur.idProfesseur]);
  }

  Future<int> deleteProfesseur(int id) async {
    Database db = await initializeDB();
    return await db.delete('Professeur', where: 'id = ?', whereArgs: [id]);
  }

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

  Future<int> updateEvaluation(Evaluation evaluation) async {
    Database db = await initializeDB();
    return await db.update('Evaluation', evaluation.toMap(),
        where: 'id = ?', whereArgs: [evaluation.id]);
  }

  Future<int> deleteEvaluation(int id) async {
    Database db = await initializeDB();
    return await db.delete('Evaluation', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> insertRecompense(Recompense recompense) async {
    Database db = await initializeDB();
    return await db.insert('Recompense', recompense.toMap());
  }

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

  Future<int> updateRecompense(Recompense recompense) async {
    Database db = await initializeDB();
    return await db.update('Recompense', recompense.toMap(),
        where: 'id = ?', whereArgs: [recompense.id]);
  }

  Future<int> deleteRecompense(int id) async {
    Database db = await initializeDB();
    return await db.delete('Recompense', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> insertRecompenseEvaluation(
      RecompenseEvaluation recompenseEvaluation) async {
    Database db = await initializeDB();
    return await db.insert(
        'RecompenseEvaluation', recompenseEvaluation.toMap());
  }

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

  Future<int> updateRecompenseEvaluation(
      RecompenseEvaluation recompenseEvaluation) async {
    Database db = await initializeDB();
    return await db.update('RecompenseEvaluation', recompenseEvaluation.toMap(),
        where: 'id = ?', whereArgs: [recompenseEvaluation.id]);
  }

  Future<int> deleteRecompenseEvaluation(int id) async {
    Database db = await initializeDB();
    return await db
        .delete('RecompenseEvaluation', where: 'id = ?', whereArgs: [id]);
  }

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
