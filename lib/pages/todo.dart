import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  DateTime? selectedDateDebut;
  DateTime? selectedDateEcheance;
  List<Matiere> _matieres = [];
  List<Professeur> _professeurs = [];
  List<Devoir> _devoirs = [];
  List<Appointment> _devoirsToAppointments() {
    return _devoirs.map((devoir) {
      Matiere matiere = _matieres
          .firstWhere((matiere) => matiere.idMatiere == devoir.idMatiere);
      Professeur professeur = _professeurs.firstWhere(
          (professeur) => professeur.idProfesseur == devoir.idProfesseur);
      return Appointment(
          id: devoir.id,
          startTime: devoir.dateEcheance,
          endTime: devoir.dateEcheance,
          subject: devoir.titre +
              ' - ' +
              matiere.nomMatiere +
              ' - ' +
              professeur.genreProfesseur.toString().split('.').last +
              '. ' +
              professeur.nomProfesseur,
          isAllDay: true,
          notes: devoir.description +
              ' - Priorité: ' +
              devoir.priorite.toString().split('.').last);
    }).toList();
  }

  TextEditingController _dateDebutController = TextEditingController();
  TextEditingController _dateEcheanceController = TextEditingController();
  final titreController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    _dateDebutController.dispose();
    _dateEcheanceController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getMatieres();
    _getProfesseurs();
    _getDevoirs();
  }

  _getMatieres() async {
    _matieres = await SqliteService().getAllMatieres();
  }

  _getProfesseurs() async {
    _professeurs = await SqliteService().getAllProfesseurs();
  }

  _getDevoirs() async {
    _devoirs = await SqliteService().getAllDevoirs();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfCalendar(
        view: CalendarView.month,
        monthViewSettings: const MonthViewSettings(
          showAgenda: true,
          appointmentDisplayCount: 4,
          appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
          // agendaViewHeight: 380,
          agendaItemHeight: 40,
        ),
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
        dataSource: _MyDataSource(_devoirsToAppointments()),
        appointmentBuilder: (context, details) {
          final Appointment appointment = details.appointments.toList()[0];
          int appointmentId = appointment.id as int;
          return GestureDetector(
            onTap: () {
              Devoir devoir = _devoirs.firstWhere((d) => d.id == appointmentId);
              _selectedPriority = devoir.priorite;
              _selectedMatiere =
                  _matieres.firstWhere((m) => m.idMatiere == devoir.idMatiere);
              _selectedProfesseur = _professeurs
                  .firstWhere((p) => p.idProfesseur == devoir.idProfesseur);
              selectedDateEcheance = appointment.endTime;
              _dateEcheanceController.text =
                  DateFormat('yyyy-MM-dd').format(devoir.dateEcheance);
              titreController.text = devoir.titre;
              descriptionController.text = devoir.description;
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Editer un devoir'),
                    content: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
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
                                  builder:
                                      (BuildContext context, Widget? child) {
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
                                  selectedDateEcheance = date;
                                  _dateEcheanceController.text =
                                      date.toString().split(' ')[0];
                                });
                              }
                            },
                            controller: _dateEcheanceController,
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
                                .map<DropdownMenuItem<Priorite>>(
                                    (Priorite value) {
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
                    ),
                    actions: [
                      TextButton(
                          onPressed: () async {
                            SqliteService sqliteService = SqliteService();
                            sqliteService.deleteDevoir(appointmentId);
                            await _getDevoirs();
                            Navigator.of(context).pop();
                          },
                          child: const Text('Supprimer')),
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
                              id: appointmentId,
                              titre: titreController.text,
                              description: descriptionController.text,
                              dateEcheance: selectedDateEcheance!,
                              priorite: _selectedPriority!,
                              idMatiere: _selectedMatiere!.idMatiere!,
                              idProfesseur: _selectedProfesseur!.idProfesseur!);
                          SqliteService sqliteService = SqliteService();
                          int updateId =
                              await sqliteService.updateDevoir(devoir);
                          await _getDevoirs();
                          if (updateId > 0) {
                            Fluttertoast.showToast(
                                msg: 'Devoir modifié',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else {
                            Fluttertoast.showToast(
                                msg: 'Erreur lors de la modification du devoir',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: Container(
              width: details.bounds.width,
              height: details.bounds.height,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      appointment.subject,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      appointment.notes!,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
                              selectedDateEcheance = date;
                              _dateEcheanceController.text =
                                  date.toString().split(' ')[0];
                            });
                          }
                        },
                        controller: _dateEcheanceController,
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
                      if (titreController.text.isEmpty ||
                          selectedDateEcheance == null ||
                          _selectedPriority == null ||
                          _selectedMatiere == null ||
                          _selectedProfesseur == null) {
                        Fluttertoast.showToast(
                            msg: 'Veuillez remplir tous les champs',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else {
                        Devoir devoir = Devoir(
                            id: null,
                            titre: titreController.text,
                            description: descriptionController.text,
                            dateEcheance: selectedDateEcheance!,
                            priorite: _selectedPriority!,
                            idMatiere: _selectedMatiere!.idMatiere!,
                            idProfesseur: _selectedProfesseur!.idProfesseur!);
                        SqliteService sqliteService = SqliteService();
                        int insertionId =
                            await sqliteService.insertDevoir(devoir);
                        await _getDevoirs();
                        if (insertionId > 0) {
                          Fluttertoast.showToast(
                              msg: 'Devoir ajouté',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {
                          Fluttertoast.showToast(
                              msg: 'Erreur lors de l\'ajout du devoir',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                        titreController.clear();
                        descriptionController.clear();
                        _dateDebutController.clear();
                        _dateDebutController.clear();
                        selectedDateEcheance = null;
                        _selectedPriority = null;
                        _selectedMatiere = null;
                        _selectedProfesseur = null;
                        Navigator.of(context).pop();
                      }
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

class _MyDataSource extends CalendarDataSource {
  _MyDataSource(List<Appointment> source) {
    appointments = source;
  }
}
