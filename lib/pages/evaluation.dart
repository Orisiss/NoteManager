import 'package:flutter/material.dart';

class MyEvaluationPage extends StatelessWidget {
  const MyEvaluationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes évaluations'),
      ),
      body: ListView.builder(
        itemCount: evaluations.length,
        itemBuilder: (context, index) {
          final evaluation = evaluations[index];
          Color gradeColor;
          if (evaluation.grade >= 16) {
            gradeColor = Colors.green;
          } else if (evaluation.grade >= 12) {
            gradeColor = Colors.orange;
          } else {
            gradeColor = Colors.red;
          }
          return ListTile(
            title: Text(
              evaluation.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(evaluation.description),
            trailing: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: gradeColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                evaluation.grade.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 500,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Ajouter une tâche',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Titre',
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Description',
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Date échéance',
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Priorité',
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Matière',
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Evaluation {
  final String title;
  final String description;
  final int grade;

  Evaluation({
    required this.title,
    required this.description,
    required this.grade,
  });
}

final List<Evaluation> evaluations = [
  Evaluation(
    title: 'Evaluation 1',
    description: 'This is the first evaluation',
    grade: 18,
  ),
  Evaluation(
    title: 'Evaluation 2',
    description: 'This is the second evaluation',
    grade: 14,
  ),
  Evaluation(
    title: 'Evaluation 3',
    description: 'This is the third evaluation',
    grade: 9,
  ),
];