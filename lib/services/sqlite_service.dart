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
        valeur INTEGER NOT NULL,
        date DATETIME NOT NULL,
        id_matiere INTEGER NOT NULL,
        FOREIGN KEY (id_matiere) REFERENCES Matière(id)
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
        nom TEXT NOT NULL
        );
      ''');

      await database.execute('''
        CREATE TABLE RecompenseEvaluation (
        id_devoir INTEGER NOT NULL,
        id_recompense INTEGER NOT NULL,
        date_obtention DATETIME NOT NULL,
        FOREIGN KEY (id_devoir) REFERENCES Devoir(id),
        FOREIGN KEY (id_recompense) REFERENCES Recompense(id)
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
    return await db.insert('Evaluation', evaluation.toMap());
  }

  Future<List<Evaluation>> getAllEvaluations() async {
    Database db = await initializeDB();
    List<Map<String, dynamic>> maps = await db.query('Evaluation');
    return List.generate(maps.length, (i) {
      return Evaluation(
        idEvaluation: maps[i][Evaluation.id],
        titleEvaluation: maps[i][Evaluation.title],
        valeurEvaluation: maps[i][Evaluation.valeur],
        dateEvaluation: maps[i][Evaluation.date],
        idMatiereEvaluation: maps[i][Evaluation.id_matiere],
      );
    });
  }

  Future<int> updateEvaluation(Evaluation evaluation) async {
    Database db = await initializeDB();
    return await db.update('Evaluation', evaluation.toMap(),
        where: 'id = ?', whereArgs: [evaluation.idEvaluation]);
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
    List<Map<String, dynamic>> maps = await db.query('Recompense');
    return List.generate(maps.length, (i) {
      return Recompense(
        idRecompense: maps[i][Recompense.id],
        nomRecompense: maps[i][Recompense.nom],
      );
    });
  }

  Future<int> updateRecompense(Recompense recompense) async {
    Database db = await initializeDB();
    return await db.update('Recompense', recompense.toMap(),
        where: 'id = ?', whereArgs: [recompense.idRecompense]);
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
    List<Map<String, dynamic>> maps = await db.query('RecompenseEvaluation');
    return List.generate(maps.length, (i) {
      return RecompenseEvaluation(
        idRecompenseEvaluation: maps[i][RecompenseEvaluation.id],
        idRecompenseRecompenseEvaluation: maps[i]
            [RecompenseEvaluation.idRecompense],
        idEvaluationRecompenseEvaluation: maps[i]
            [RecompenseEvaluation.idEvaluation],
        dateObtentionRecompenseEvaluation: maps[i]
            [RecompenseEvaluation.dateObtention],
      );
    });
  }

  Future<int> updateRecompenseEvaluation(
      RecompenseEvaluation recompenseEvaluation) async {
    Database db = await initializeDB();
    return await db.update('RecompenseEvaluation', recompenseEvaluation.toMap(),
        where: 'id = ?',
        whereArgs: [recompenseEvaluation.idRecompenseEvaluation]);
  }

  Future<int> deleteRecompenseEvaluation(int id) async {
    Database db = await initializeDB();
    return await db
        .delete('RecompenseEvaluation', where: 'id = ?', whereArgs: [id]);
  }
}
