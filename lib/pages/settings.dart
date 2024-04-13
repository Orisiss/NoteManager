import 'package:flutter/material.dart';
import 'package:note_manager/models/matiere.dart';
import 'package:note_manager/models/professeur.dart';
import 'package:note_manager/services/sqlite_service.dart';

class MySettingsPage extends StatefulWidget {
  const MySettingsPage({Key? key}) : super(key: key);

  @override
  _MySettingsPageState createState() => _MySettingsPageState();
}

class _MySettingsPageState extends State<MySettingsPage> {
  String _selectedLanguage = 'French';
  String? _selectedDay;
  final Map<String, String> _subjectAssignments = {};
  final matiereController = TextEditingController();
  final professeurController = TextEditingController();
  final prenomController = TextEditingController();
  final nomController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Réglages'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                            decoration: const InputDecoration(
                              labelText: 'Nom de la matière',
                            ),
                          )
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () async {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Enregistrer'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Ajouter des matières'),
            ),
            const SizedBox(height: 16),
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
                          TextFormField(
                            controller: prenomController,
                            decoration: const InputDecoration(
                              labelText: 'Prénom du professeur',
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
                            ProfesseurColumn professeurColumn =
                                ProfesseurColumn(
                              prenomProfesseur: prenomController.text,
                              nomProfesseur: nomController.text,
                            );
                            SqliteService sqliteService = SqliteService();
                            await sqliteService.insertProfesseur(professeurColumn);
                            List<ProfesseurColumn> professeurs =
                                await sqliteService.getAllProfesseurs();

                            for (ProfesseurColumn professeur in professeurs) {
                              print(
                                  'ID: ${professeur.idProfesseur}, Prénom: ${professeur.prenomProfesseur}, Nom: ${professeur.nomProfesseur}');
                            }
                            Navigator.of(context).pop();
                          },
                          child: const Text('Enregistrer'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Ajouter des professeurs'),
            ),
            const SizedBox(height: 16),
            const Text('Sélectionner la langue:',
                style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            DropdownButton<String>(
              value: _selectedLanguage,
              items: <String>['English', 'French', 'Spanish', 'German']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedLanguage = newValue!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
