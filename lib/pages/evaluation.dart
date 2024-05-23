import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:note_manager/models/evaluation.dart';
import 'package:note_manager/models/matiere.dart';
import 'package:note_manager/services/sqlite_service.dart';

class MyEvaluationPage extends StatefulWidget {
  const MyEvaluationPage({Key? key}) : super(key: key);

  @override
  _MyEvaluationPageState createState() => _MyEvaluationPageState();
}

class _MyEvaluationPageState extends State<MyEvaluationPage> {
  TextEditingController _titreController = TextEditingController();
  TextEditingController _noteController = TextEditingController();
  TextEditingController _coefController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;
  Matiere? _selectedMatiere;
  List<Matiere> _matieres = [];
  List<Evaluation> _evaluations = [];

  @override
  void initState() {
    super.initState();
    _getMatieres();
    _getEvaluations();
  }

  _getMatieres() async {
    _matieres = await SqliteService().getAllMatieres();
  }

  _getEvaluations() async {
    _evaluations = await SqliteService().getAllEvaluations();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Évaluations'),
      ),
      body: FutureBuilder<List<Evaluation>>(
        future: SqliteService().getAllEvaluations(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: InkWell(
                    onTap: () {
                      Evaluation evaluation = _evaluations
                          .firstWhere((e) => e.id == snapshot.data![index].id);
                      _titreController.text = evaluation.titre;
                      _noteController.text = evaluation.valeur.toString();
                      _coefController.text = evaluation.coef.toString();
                      _dateController.text =
                          DateFormat('yyyy-MM-dd').format(evaluation.date);
                      _selectedDate = evaluation.date;
                      _selectedMatiere = _matieres.firstWhere(
                          (m) => m.idMatiere == evaluation.idMatiere);

                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Éditer l'évaluation"),
                            content: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFormField(
                                    controller: _titreController,
                                    decoration: const InputDecoration(
                                      labelText: 'Titre',
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    controller: _noteController,
                                    decoration: const InputDecoration(
                                      labelText: 'Valeur',
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    controller: _coefController,
                                    decoration: const InputDecoration(
                                      labelText: 'Coefficient',
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    onTap: () async {
                                      var date = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(2101),
                                          builder: (BuildContext context,
                                              Widget? child) {
                                            return Theme(
                                              data: ThemeData.light().copyWith(
                                                colorScheme:
                                                    const ColorScheme.light(
                                                  primary: Colors.purple,
                                                ),
                                              ),
                                              child: child!,
                                            );
                                          });
                                      if (date != null) {
                                        setState(() {
                                          _selectedDate = date;
                                          _dateController.text =
                                              date.toString().split(' ')[0];
                                        });
                                      }
                                    },
                                    controller: _dateController,
                                    decoration: const InputDecoration(
                                      labelText: "Date de l'évaluation",
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  DropdownButtonFormField<Matiere>(
                                    value: _selectedMatiere,
                                    onChanged: (Matiere? newValue) {
                                      setState(() {
                                        _selectedMatiere = newValue;
                                      });
                                    },
                                    items: _matieres.map((Matiere matiere) {
                                      return DropdownMenuItem<Matiere>(
                                        value: matiere,
                                        child: Text(matiere.nomMatiere),
                                      );
                                    }).toList(),
                                    decoration: const InputDecoration(
                                      labelText: 'Matière',
                                    ),
                                  ),
                                  const SizedBox(height: 10)
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () async {
                                    SqliteService sqliteService =
                                        SqliteService();
                                    sqliteService.deleteEvaluation(
                                        snapshot.data![index].id!);
                                    await _getEvaluations();
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Supprimer')),
                              TextButton(
                                  onPressed: () async {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Annuler')),
                              TextButton(
                                  onPressed: () async {
                                    Evaluation evaluation = Evaluation(
                                        id: snapshot.data![index].id!,
                                        titre: _titreController.text,
                                        valeur: int.parse(_noteController.text),
                                        coef: int.parse(_coefController.text),
                                        date: _selectedDate!,
                                        idMatiere:
                                            _selectedMatiere!.idMatiere!);
                                    SqliteService sqliteService =
                                        SqliteService();
                                    int updateId = await sqliteService
                                        .updateEvaluation(evaluation);
                                    await _getEvaluations();
                                    if (updateId > 0) {
                                      Fluttertoast.showToast(
                                          msg: 'Evaluation modifiée',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.green,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "Erreur lors de la modification de l'évaluation",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    }
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Valider'))
                            ],
                          );
                        },
                      );
                    },
                    child: ListTile(
                      title: Text(
                        snapshot.data![index].titre,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Note: ${snapshot.data![index].valeur}/20 (Coef: ${snapshot.data![index].coef})',
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      trailing: Text(
                        snapshot.data![index].date.toString().split(' ')[0],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Ajouter un élément'),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _titreController,
                        decoration: const InputDecoration(
                          labelText: 'Titre',
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _noteController,
                        decoration: const InputDecoration(
                          labelText: 'Note sur 20',
                        ),
                        validator: (value) {
                          int? note = int.tryParse(value!);
                          if (note == null || note < 0 || note > 20) {
                            return 'La note doit être comprise entre 0 et 20';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _coefController,
                        decoration: const InputDecoration(
                          labelText: 'Coefficient',
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        onTap: () async {
                          var date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                              builder: (BuildContext context, Widget? child) {
                                return Theme(
                                  data: ThemeData.light().copyWith(
                                    colorScheme: const ColorScheme.light(
                                      primary: Colors.purple,
                                    ),
                                  ),
                                  child: child!,
                                );
                              });
                          if (date != null) {
                            setState(() {
                              _selectedDate = date;
                              _dateController.text =
                                  date.toString().split(' ')[0];
                            });
                          }
                        },
                        controller: _dateController,
                        decoration: const InputDecoration(
                          labelText: "Date de l'évaluation",
                        ),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<Matiere>(
                        value: _selectedMatiere,
                        onChanged: (Matiere? newValue) {
                          setState(() {
                            _selectedMatiere = newValue;
                          });
                        },
                        items: _matieres.map((Matiere matiere) {
                          return DropdownMenuItem<Matiere>(
                            value: matiere,
                            child: Text(matiere.nomMatiere),
                          );
                        }).toList(),
                        decoration: const InputDecoration(
                          labelText: 'Matière',
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    child: const Text('Annuler'),
                    onPressed: () async {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    onPressed: () async {
                      if (_titreController.text.isEmpty ||
                          _noteController.text.isEmpty ||
                          _coefController.text.isEmpty ||
                          _selectedDate == null ||
                          _selectedMatiere == null) {
                        Fluttertoast.showToast(
                            msg: 'Veuillez remplir tous les champs',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else {
                        Evaluation evaluation = Evaluation(
                            id: null,
                            titre: _titreController.text,
                            valeur: int.parse(_noteController.text),
                            coef: int.parse(_coefController.text),
                            date: _selectedDate!,
                            idMatiere: _selectedMatiere!.idMatiere!);
                        SqliteService sqliteService = SqliteService();
                        int insertionId =
                            await sqliteService.insertEvaluation(evaluation);
                        await _getEvaluations();
                        if (insertionId > 0) {
                          Fluttertoast.showToast(
                              msg: 'Evaluation ajoutée',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {
                          Fluttertoast.showToast(
                              msg: 'Erreur lors de l\'ajout de l\'évaluation',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                        _titreController.clear();
                        _noteController.clear();
                        _coefController.clear();
                        _dateController.clear();
                        _selectedDate = null;
                        _selectedMatiere = null;
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Ajouter'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
