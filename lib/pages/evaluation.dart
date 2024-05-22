import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _noteController = TextEditingController();
  TextEditingController _coefController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;
  Matiere? _selectedMatiere;
  List<Matiere> _matieres = [];
  List<Evaluation> _evaluations = [];

  List<String> evaluations = [];

  @override
  void initState() {
    super.initState();
    _getMatieres();
  }

  _getMatieres() async {
    _matieres = await SqliteService().getAllMatieres();
  }

  _getEvaluations() async {
    _evaluations = await SqliteService().getAllEvaluations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes évaluations'),
      ),
      body: ListView.builder(
        itemCount: evaluations.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(evaluations[index]),
          );
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
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                          labelText: 'Description',
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
