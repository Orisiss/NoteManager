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
  final nomMatiereController = TextEditingController();
  final genreController = TextEditingController();
  Genre? _selectedGenre;
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
                              nomMatiere: nomMatiereController.text,
                            );
                            SqliteService sqliteService = SqliteService();
                            await sqliteService.insertMatiere(matiereColumn);
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
                          DropdownButtonFormField<Genre>(
                            value: _selectedGenre,
                            items: Genre.values.map((Genre genre) {
                              return DropdownMenuItem<Genre>(
                                value: genre,
                                child: Text(genre.toString().split('.').last),
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
                              idProfesseur: null,
                              genreProfesseur: _selectedGenre!,
                              nomProfesseur: nomController.text,
                            );
                            SqliteService sqliteService = SqliteService();
                            await sqliteService
                                .insertProfesseur(professeur);
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
