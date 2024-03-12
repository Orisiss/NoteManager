import 'package:flutter/material.dart';
import 'package:note_manager/widgets/tabbar.dart';

void main() {
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
      home: TabBarWidget(),
    );
  }
}