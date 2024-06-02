import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:note_manager/models/matiere.dart';
import 'package:note_manager/models/professeur.dart';
import 'package:note_manager/services/sqlite_service.dart';

/// Page de réglages de l'application.
class MySettingsPage extends StatefulWidget {
  const MySettingsPage({Key? key}) : super(key: key);

  @override
  _MySettingsPageState createState() => _MySettingsPageState();
}

class _MySettingsPageState extends State<MySettingsPage> {
  final nomMatiereController = TextEditingController();
  final nomController = TextEditingController();

  Genre? _selectedGenre;
  Matiere? _selectedMatiere;
  Professeur? _selectedProfesseur;
  
  List<Professeur> _professeurs = [];
  List<Matiere> _matieres = [];

  @override
  void initState() {
    super.initState();
    _getProfesseurs();
    _getMatieres();
  }

  /// Récupère la liste des professeurs depuis la base de données.
  _getProfesseurs() async {
    _professeurs = await SqliteService().getAllProfesseurs();
    setState(() {});
  }

  /// Récupère la liste des matières depuis la base de données.
  _getMatieres() async {
    _matieres = await SqliteService().getAllMatieres();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Réglages'),
      ),
      body: SingleChildScrollView(
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Supprimer une matière'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text('Mes évaluations:'),
                                    const SizedBox(height: 10),
                                    DropdownButtonFormField<Matiere>(
                                      value: _selectedMatiere,
                                      items: _matieres.map((Matiere matiere) {
                                        return DropdownMenuItem<Matiere>(
                                          value: matiere,
                                          child: Text(matiere.nom),
                                        );
                                      }).toList(),
                                      onChanged: (Matiere? newValue) {
                                        setState(() {
                                          _selectedMatiere = newValue!;
                                        });
                                      },
                                      decoration: const InputDecoration(
                                        labelText: 'Matière',
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Annuler')),
                                  const SizedBox(width: 40),
                                  TextButton(
                                      child: const Text('Supprimer'),
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.red,
                                      ),
                                      onPressed: () async {
                                        if (_selectedMatiere != null) {
                                          SqliteService sqliteService =
                                              SqliteService();
                                          int suppressionSuccess =
                                              await sqliteService.deleteMatiere(
                                                  _selectedMatiere?.id ?? 0);
                                          if (suppressionSuccess > 0) {
                                            Fluttertoast.showToast(
                                                msg: 'Matière supprimée',
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.green,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                            _getMatieres();
                                            Navigator.of(context).pop();
                                          } else {
                                            Fluttertoast.showToast(
                                                msg:
                                                    'Erreur lors de la suppression de la matière',
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          }
                                        } else {
                                          Fluttertoast.showToast(
                                              msg:
                                                  'Veuillez sélectionner une matière',
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        }
                                      })
                                ],
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(16.0),
                        ),
                        child: const Icon(Icons.delete),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Ajouter des matières'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextFormField(
                                      controller: nomMatiereController,
                                      decoration: const InputDecoration(
                                        labelText: 'Nom de la matière',
                                      ),
                                    )
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () async {
                                      Matiere matiereColumn = Matiere(
                                        nom: nomMatiereController.text,
                                      );
                                      SqliteService sqliteService =
                                          SqliteService();
                                      int insertionSuccess = await sqliteService
                                          .insertMatiere(matiereColumn);
                                      if (insertionSuccess > 0) {
                                        Fluttertoast.showToast(
                                            msg: 'Matière ajoutée',
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.green,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                        nomMatiereController.clear();
                                        Navigator.of(context).pop();
                                      } else {
                                        Fluttertoast.showToast(
                                            msg:
                                                'Erreur lors de l\'insertion de la matière',
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      }
                                      nomMatiereController.clear();
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Enregistrer'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24.0,
                            vertical: 16.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text('Ajouter des matières'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          SqliteService sqliteService = SqliteService();
                          List<Matiere> matieres =
                              await sqliteService.getAllMatieres();
                          List<String> matieresNames = [];
                          for (Matiere matiere in matieres) {
                            matieresNames.add(matiere.nom);
                          }
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    title: const Text('Modifier une matière'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        DropdownButtonFormField<Matiere>(
                                          value: _selectedMatiere,
                                          items:
                                              matieres.map((Matiere matiere) {
                                            return DropdownMenuItem<Matiere>(
                                              value: matiere,
                                              child: Text(matiere.nom),
                                            );
                                          }).toList(),
                                          onChanged: (Matiere? newValue) {
                                            setState(() {
                                              _selectedMatiere = newValue!;
                                            });
                                          },
                                          decoration: const InputDecoration(
                                            labelText: 'Matière',
                                          ),
                                        ),
                                        TextFormField(
                                          controller: nomMatiereController,
                                          decoration: const InputDecoration(
                                            labelText: 'Nouveau nom',
                                          ),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Annuler')),
                                      const SizedBox(width: 40),
                                      TextButton(
                                          child: const Text('Modifier'),
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.blue,
                                          ),
                                          onPressed: () async {
                                            if (_selectedMatiere != null) {
                                              Matiere matiere = Matiere(
                                                id: _selectedMatiere?.id,
                                                nom: nomMatiereController.text,
                                              );
                                              int updateSuccess =
                                                  await sqliteService
                                                      .updateMatiere(matiere);
                                              if (updateSuccess > 0) {
                                                Fluttertoast.showToast(
                                                    msg: 'Matière modifiée',
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor:
                                                        Colors.green,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                                _getMatieres();
                                                Navigator.of(context).pop();
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        'Erreur lors de la modification de la matière',
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors.red,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                              }
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      'Veuillez sélectionner une matière',
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            }
                                            nomMatiereController.clear();
                                            Navigator.of(context).pop();
                                            // _getMatieres();
                                          })
                                    ]);
                              });
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(16.0),
                        ),
                        child: const Icon(Icons.edit),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Supprimer un(e) professeur'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text('Mes professeurs:'),
                                    const SizedBox(height: 10),
                                    DropdownButtonFormField<Professeur>(
                                      value: _selectedProfesseur,
                                      items: _professeurs
                                          .map((Professeur professeur) {
                                        return DropdownMenuItem<Professeur>(
                                          value: professeur,
                                          child: Text(professeur.nom),
                                        );
                                      }).toList(),
                                      onChanged: (Professeur? newValue) {
                                        setState(() {
                                          _selectedProfesseur = newValue!;
                                        });
                                      },
                                      decoration: const InputDecoration(
                                        labelText: 'Professeur',
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Annuler')),
                                  const SizedBox(width: 40),
                                  TextButton(
                                      child: const Text('Supprimer'),
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.red,
                                      ),
                                      onPressed: () async {
                                        if (_selectedProfesseur != null) {
                                          SqliteService sqliteService =
                                              SqliteService();
                                          int suppressionSuccess =
                                              await sqliteService
                                                  .deleteProfesseur(
                                                      _selectedProfesseur?.id ??
                                                          0);
                                          if (suppressionSuccess > 0) {
                                            Fluttertoast.showToast(
                                                msg: 'Professeur supprimé(e)',
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.green,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                            _getProfesseurs();
                                            Navigator.of(context).pop();
                                          } else {
                                            Fluttertoast.showToast(
                                                msg:
                                                    'Erreur lors de la suppression du professeur',
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          }
                                        } else {
                                          Fluttertoast.showToast(
                                              msg:
                                                  'Veuillez sélectionner un professeur',
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        }
                                      })
                                ],
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(16.0),
                        ),
                        child: const Icon(Icons.delete),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Ajouter des professeurs'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    DropdownButtonFormField<Genre>(
                                      value: _selectedGenre,
                                      items: Genre.values.map((Genre genre) {
                                        return DropdownMenuItem<Genre>(
                                          value: genre,
                                          child: Text(
                                              genre.toString().split('.').last),
                                        );
                                      }).toList(),
                                      onChanged: (Genre? newValue) {
                                        setState(() {
                                          _selectedGenre = newValue!;
                                        });
                                      },
                                      decoration: const InputDecoration(
                                        labelText: 'Genre',
                                      ),
                                    ),
                                    TextFormField(
                                      controller: nomController,
                                      decoration: const InputDecoration(
                                        labelText: 'Nom du professeur',
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () async {
                                      Professeur professeur = Professeur(
                                        id: null,
                                        genre: _selectedGenre!,
                                        nom: nomController.text,
                                      );
                                      SqliteService sqliteService =
                                          SqliteService();
                                      int insertionSuccess = await sqliteService
                                          .insertProfesseur(professeur);
                                      if (insertionSuccess > 0) {
                                        Fluttertoast.showToast(
                                            msg: 'Professeur ajouté(e)',
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.green,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                        nomMatiereController.clear();
                                        Navigator.of(context).pop();
                                      } else {
                                        Fluttertoast.showToast(
                                            msg:
                                                'Erreur lors de l\'insertion du professeur',
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      }
                                      _selectedGenre = null;
                                      nomController.clear();
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Enregistrer'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24.0,
                            vertical: 16.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text('Ajouter des professeurs'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          SqliteService sqliteService = SqliteService();
                          List<Professeur> professeurs =
                              await sqliteService.getAllProfesseurs();
                          List<String> professeursNames = [];
                          for (Professeur professeur in professeurs) {
                            professeursNames.add(professeur.nom);
                          }
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    title:
                                        const Text('Modifier un(e) professeur'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        DropdownButtonFormField<Professeur>(
                                          value: _selectedProfesseur,
                                          onChanged: (Professeur? newValue) {
                                            setState(() {
                                              _selectedProfesseur = newValue;
                                              _selectedGenre = newValue?.genre;
                                              nomController.text =
                                                  newValue?.nom ?? '';
                                            });
                                          },
                                          items: _professeurs
                                              .map((Professeur professeur) {
                                            return DropdownMenuItem<Professeur>(
                                              value: professeur,
                                              child: Text(
                                                '${professeur.genre.toString().split('.').last} ${professeur.nom}',
                                              ),
                                            );
                                          }).toList(),
                                          decoration: const InputDecoration(
                                            labelText: 'Professeur',
                                          ),
                                        ),
                                        TextFormField(
                                          controller: nomController,
                                          decoration: const InputDecoration(
                                            labelText: 'Nouveau nom',
                                          ),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            _selectedProfesseur = null;
                                            _selectedGenre = null;
                                            nomController.clear();
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Annuler')),
                                      const SizedBox(width: 40),
                                      TextButton(
                                          child: const Text('Modifier'),
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.blue,
                                          ),
                                          onPressed: () async {
                                            if (_selectedProfesseur != null) {
                                              Professeur professeur = Professeur(
                                                id: _selectedProfesseur?.id,
                                                genre: _selectedGenre!,
                                                nom: nomController.text,
                                              );
                                              int updateSuccess =
                                                  await sqliteService
                                                      .updateProfesseur(professeur);
                                              if (updateSuccess > 0) {
                                                Fluttertoast.showToast(
                                                    msg: 'Professeur modifié(e)',
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor:
                                                        Colors.green,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                                _getProfesseurs();
                                                Navigator.of(context).pop();
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        'Erreur lors de la modification du professeur',
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors.red,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                              }
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      'Veuillez sélectionner un(e) professeur',
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            }
                                            nomController.clear();
                                            Navigator.of(context).pop();
                                            // _getMatieres();
                                          })
                                    ]);
                              });
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(16.0),
                        ),
                        child: const Icon(Icons.edit),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
