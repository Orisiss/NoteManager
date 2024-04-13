import 'package:flutter/material.dart';
import 'package:note_manager/services/sqlite_service.dart';
import 'package:note_manager/widgets/tabbar.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SqliteService sqliteService = SqliteService();
  Database db = await sqliteService.initializeDB();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note Manager',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const TabBarWidget(),
    );
  }
}