import 'package:note_manager/models/devoir.dart';
import 'package:note_manager/models/evaluation.dart';
import 'package:note_manager/models/matiere.dart';
import 'package:note_manager/models/professeur.dart';
import 'package:note_manager/models/recompense.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqliteService {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();

    return openDatabase(join(path, 'database.db'),
        onCreate: (database, version) async {
      await database.execute('''
          "CREATE TABLE Devoir (
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            titre TEXT NOT NULL, 
            description TEXT, 
            date_echeance TEXT NOT NULL, 
            priorite INTEGER NOT NULL,
            id_matiere INTEGER NOT NULL,
            FOREIGN KEY (id_matiere) REFERENCES matiere (id) ON DELETE NO ACTION ON UPDATE NO ACTION)",
        )''');

      await database.execute('''
          "CREATE TABLE Matiere (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nom TEXT NOT NULL,
            id_professeur INTEGER NOT NULL,
            FOREIGN KEY (id_professeur) REFERENCES professeur (id) ON DELETE NO ACTION ON UPDATE NO ACTION)",
        )''');

      await database.execute('''
          "CREATE TABLE Evaluation (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            valeur INTEGER NOT NULL,
            date INTEGER NOT NULL,
            id_matiere INTEGER NOT NULL,
            FOREIGN KEY (id_matiere) REFERENCES matiere (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
            )",
        )''');

      await database.execute('''
          "CREATE TABLE Professeur (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            prenom TEXT NOT NULL,
            nom TEXT NOT NULL,
            )",
        )''');

      await database.execute('''
          "CREATE TABLE Recompense (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            id_recompense INTEGER NOT NULL,
            id_evaluation INTEGER NOT NULL,
            FOREIGN KEY (id_recompense) REFERENCES recompense (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
            FOREIGN KEY (id_evaluation) REFERENCES evaluation (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
            )",
        )''');
    }, version: 1);
  }

  Future<int> insertDevoir(Devoir devoir) async {
    Database db = await this.initializeDB();
    return await db.insert('Devoir', devoir.toMap());
  }

  Future<List<Devoir>> getAllDevoirs() async {
    Database db = await this.initializeDB();
    List<Map<String, dynamic>> maps = await db.query('Devoir');
    return List.generate(maps.length, (i) {
      return Devoir(
        idDevoir: maps[i][Devoir.id],
        titreDevoir: maps[i][Devoir.titre], 
        descriptionDevoir: maps[i][Devoir.description], 
        dateEcheanceDevoir: maps[i][Devoir.dateEcheance], 
        prioriteDevoir: maps[i][Devoir.priorite], 
        idMatiereDevoir: maps[i][Devoir.idMatiere],
        );
    });
  }

  Future<int> updateDevoir(Devoir devoir) async {
    Database db = await this.initializeDB();
    return await db.update('Devoir', devoir.toMap(),
        where: 'id = ?', 
        whereArgs: [devoir.idDevoir]);
  }

  Future<int> deleteDevoir(int id) async {
    Database db = await this.initializeDB();
    return await db.delete('Devoir', where: 'id =?', whereArgs: [id]);
  }

  Future<int> insertMatiere(MatiereColumn matiere) async {
    Database db = await this.initializeDB();
    return await db.insert('Matiere', matiere.toMap());
  }

  Future<List<MatiereColumn>> getAllMatieres() async {
    Database db = await this.initializeDB();
    List<Map<String, dynamic>> maps = await db.query('Matiere');
    return List.generate(maps.length, (i) {
      return MatiereColumn(
        idMatiere: maps[i][MatiereColumn.id],
        nomMatiere: maps[i][MatiereColumn.nom], 
        idProfesseurMatiere: maps[i][MatiereColumn.id_professeur],
        );
    });
  }

  Future<int> updateMatiere(MatiereColumn matiere) async {
    Database db = await this.initializeDB();
    return await db.update('Matiere', matiere.toMap(),
    where: 'id = ?',
    whereArgs: [matiere.idMatiere]);
  }

  Future<int> deleteMatiere(int id) async {
    Database db = await this.initializeDB();
    return await db.delete('Matiere', where: 'id =?', whereArgs: [id]);
  }

  Future<int> insertProfesseur(ProfesseurColumn professeur) async {
    Database db = await this.initializeDB();
    return await db.insert('Professeur', professeur.toMap());
  }

  Future<List<ProfesseurColumn>> getAllProfesseurs() async {
    Database db = await this.initializeDB();
    List<Map<String, dynamic>> maps = await db.query('Professeur');
    return List.generate(maps.length, (i) {
      return ProfesseurColumn(
        idProfesseur: maps[i][ProfesseurColumn.id],
        prenomProfesseur: maps[i][ProfesseurColumn.prenom],
        nomProfesseur: maps[i][ProfesseurColumn.nom],
        );
    });
  }

  Future<int> updateProfesseur(ProfesseurColumn professeur) async {
    Database db = await this.initializeDB();
    return await db.update('Professeur', professeur.toMap(),
    where: 'id = ?',
    whereArgs: [professeur.idProfesseur]);
  }

  Future<int> deleteProfesseur(int id) async {
    Database db = await this.initializeDB();
    return await db.delete('Professeur', 
    where: 'id = ?', 
    whereArgs: [id]);
  }

  Future<int> insertEvaluation(Evaluation evaluation) async {
    Database db = await this.initializeDB();
    return await db.insert('Evaluation', evaluation.toMap());
  }

  Future<List<Evaluation>> getAllEvaluations() async {
    Database db = await this.initializeDB();
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
    Database db = await this.initializeDB();
    return await db.update('Evaluation', evaluation.toMap(),
    where: 'id = ?',
    whereArgs: [evaluation.idEvaluation]);
  }

  Future<int> deleteEvaluation(int id) async {
    Database db = await this.initializeDB();
    return await db.delete('Evaluation',
    where: 'id = ?',
    whereArgs: [id]);
  }

  Future<int> insertRecompense(RecompenseColumn recompense) async {
    Database db = await this.initializeDB();
    return await db.insert('Recompense', recompense.toMap());
  }

  Future<List<RecompenseColumn>> getAllRecompenses() async {
    Database db = await this.initializeDB();
    List<Map<String, dynamic>> maps = await db.query('Recompense');
    return List.generate(maps.length, (i) {
      return RecompenseColumn(
        idRecompense: maps[i][RecompenseColumn.id],
        nomRecompense: maps[i][RecompenseColumn.nom],
        );
    });
  }

  Future<int> updateRecompense(RecompenseColumn recompense) async {
    Database db = await this.initializeDB();
    return await db.update('Recompense', recompense.toMap(),
    where: 'id = ?',
    whereArgs: [recompense.idRecompense]);
  }

  Future<int> deleteRecompense(int id) async {
    Database db = await this.initializeDB();
    return await db.delete('Recompense',
    where: 'id = ?',
    whereArgs: [id]);
  }
}