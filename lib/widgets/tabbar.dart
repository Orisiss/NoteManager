import 'package:flutter/material.dart';
import 'package:note_manager/pages/evaluation.dart';
import 'package:note_manager/pages/profil.dart';
import 'package:note_manager/pages/todo.dart';

/// Widget représentant une barre d'onglets.
class TabBarWidget extends StatelessWidget {
  const TabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Bienvenue John,'),
          centerTitle: false,
          bottom: const TabBar(
            indicatorColor: Color.fromRGBO(255, 163, 125, 1),
            tabs: [
              Tab(icon: Icon(Icons.task_alt_outlined)),
              Tab(icon: Icon(Icons.school_outlined)),
              Tab(icon: Icon(Icons.person_outline)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            MyTodoPage(),
            MyEvaluationPage(),
            MyProfilPage()
          ],
        ),
      ),
    );
  }
}
