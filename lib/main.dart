import 'package:flutter/material.dart';
import 'package:note_manager/services/sqlite_service.dart';
import 'package:note_manager/widgets/tabbar.dart';

/// Point d'entrée de l'application.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  SqliteService sqliteService = SqliteService();
  await sqliteService.initializeDB();
  await sqliteService.initializeRewards();
}

/// Classe principale de l'application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const TabBarWidget(),
    );
  }
}
