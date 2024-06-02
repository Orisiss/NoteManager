import 'package:flutter/material.dart';
import 'package:note_manager/models/evaluation.dart';
import 'package:note_manager/models/recompense.dart';
import 'package:note_manager/pages/settings.dart';
import 'package:note_manager/services/sqlite_service.dart';

/// Page de profil de l'utilisateur.
class MyProfilPage extends StatefulWidget {
  const MyProfilPage({Key? key}) : super(key: key);

  @override
  _MyProfilPageState createState() => _MyProfilPageState();
}

class _MyProfilPageState extends State<MyProfilPage> {
  double? average;
  int? nbRecompenseObtenu;

  @override
  void initState() {
    super.initState();
    _calculateAverage();
    _calculateRewardsObtained();
  }

  /// Calcule la moyenne générale des évaluations.
  _calculateAverage() async {
    SqliteService sqliteService = SqliteService();
    List<Evaluation> evaluations = await sqliteService.getAllEvaluations();
    if (evaluations.isNotEmpty) {
      double total = evaluations.fold(0, (sum, item) => sum + item.valeur);
      setState(() {
        average = total / evaluations.length;
      });
    }
  }

  /// Calcule le nombre de récompenses obtenues.
  _calculateRewardsObtained() async {
    SqliteService sqliteService = SqliteService();
    List<Recompense> rewards = await sqliteService.getAllRecompenses();
    List<Recompense> obtainedRewards =
        rewards.where((reward) => reward.isObtained).toList();
    setState(() {
      nbRecompenseObtenu = obtainedRewards.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon profil'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('lib/assets/avatar.png'),
              radius: 80,
            ),
            const SizedBox(height: 24),
            const Text(
              'John Doe',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Classe: SIAP-2',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 8),
            Text(
              'Moyenne générale: ${average != null ? average : 'N/A'}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 8),
            Text(
              'Récompenses: ${nbRecompenseObtenu != null ? nbRecompenseObtenu : 0}',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MySettingsPage()),
          );
        },
        child: const Icon(Icons.settings),
      ),
    );
  }
}
