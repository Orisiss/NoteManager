import 'package:flutter/material.dart';
import 'package:note_manager/models/matiere.dart';
import 'package:note_manager/models/professeur.dart';
import 'package:note_manager/services/sqlite_service.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:note_manager/models/devoir.dart';

class MyTodoPage extends StatefulWidget {
  const MyTodoPage({Key? key}) : super(key: key);

  @override
  _MyTodoPageState createState() => _MyTodoPageState();
}

class _MyTodoPageState extends State<MyTodoPage> {
  Priorite? _selectedPriority;
  Matiere? _selectedMatiere;
  Professeur? _selectedProfesseur;
  List<Matiere> _matieres = [];
  List<Professeur> _professeurs = [];
  DateTime? selectedDate;
  TextEditingController _dateController = TextEditingController();
  final titreController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getMatieres();
    _getProfesseurs();
  }

  _getMatieres() async {
    _matieres = await SqliteService().getAllMatieres();
  }

  _getProfesseurs() async {
    _professeurs = await SqliteService().getAllProfesseurs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ma Todo List'),
      ),
      body: Scaffold(
        body: SfCalendar(
          view: CalendarView.month,
          monthViewSettings: const MonthViewSettings(
              showAgenda: true, appointmentDisplayCount: 4),
          headerHeight: 50,
          headerStyle: const CalendarHeaderStyle(
            backgroundColor: Colors.purple,
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          firstDayOfWeek: 1,
          showTodayButton: true,
          showNavigationArrow: true,
          timeZone: 'Romance Standard Time',
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Ajouter un élément'),
                content: Column(
                    children: [
                      TextFormField(
                        controller: titreController,
                        decoration: const InputDecoration(
                          labelText: 'Titre',
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: descriptionController,
                        decoration: const InputDecoration(
                          labelText: 'Description',
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
                              selectedDate = date;
                              _dateController.text =
                                  date.toString().split(' ')[0];
                            });
                          }
                        },
                        controller: _dateController,
                        decoration: const InputDecoration(
                          labelText: "Date d'échéance",
                        ),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<Priorite>(
                        value: _selectedPriority,
                        onChanged: (Priorite? newValue) {
                          setState(() {
                            _selectedPriority = newValue;
                          });
                        },
                        items: Priorite.values
                            .map<DropdownMenuItem<Priorite>>((Priorite value) {
                          return DropdownMenuItem<Priorite>(
                            value: value,
                            child: Text(value.toString().split('.').last),
                          );
                        }).toList(),
                        decoration: const InputDecoration(
                          labelText: 'Priorité',
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
                      DropdownButtonFormField<Professeur>(
                        value: _selectedProfesseur,
                        onChanged: (Professeur? newValue) {
                          setState(() {
                            _selectedProfesseur = newValue;
                          });
                        },
                        items: _professeurs.map((Professeur professeur) {
                          return DropdownMenuItem<Professeur>(
                            value: professeur,
                            child: Text(
                                '${professeur.genreProfesseur.toString().split('.').last} ${professeur.nomProfesseur}'),
                          );
                        }).toList(),
                        decoration: const InputDecoration(
                          labelText: 'Professeur',
                        ),
                      )
                    ],
                ),
                actions: [
                  TextButton(
                    child: const Text('Annuler'),
                    onPressed: () async {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text('Valider'),
                    onPressed: () async {
                      Devoir devoir = Devoir(
                        id: null,
                        titre: titreController.text,
                        description: descriptionController.text,
                        dateEcheance: selectedDate!,
                        priorite: _selectedPriority!,
                        fait: 0,
                        idMatiere: _selectedMatiere!.idMatiere!,
                        idProfesseur: _selectedProfesseur!.idProfesseur!
                      );
                      SqliteService sqliteService = SqliteService();
                      await sqliteService.insertDevoir(devoir);
                      titreController.clear();
                      descriptionController.clear();
                      _dateController.clear();
                      selectedDate = null;
                      _selectedPriority = null;
                      _selectedMatiere = null;
                      _selectedProfesseur = null;
                      Navigator.of(context).pop();
                    },
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