import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';

class MyCalendarPage extends StatelessWidget {
  const MyCalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Planning'),
      ),
      body: Column(
        children: [
          CalendarTimeline(
            initialDate: selectedDate,
            firstDate: DateTime.now().subtract(const Duration(days: 30)),
            lastDate: DateTime.now().add(const Duration(days: 30)),
            onDateSelected: (date) => selectedDate = date,
            leftMargin: 20,
            monthColor: Colors.blueGrey,
            dayColor: const Color.fromRGBO(64, 71, 87, 1),
            activeDayColor: const Color.fromRGBO(255, 163, 125, 1),
            activeBackgroundDayColor: const Color.fromRGBO(65, 73, 86, 1),
            dotsColor: Colors.white,
            selectableDayPredicate: (date) => date.day != 23,
            showYears: true,
            locale: 'fr',
          ),
          const SizedBox(height: 20),
          _buildScheduleCard(
            title: 'Cours de mathématiques',
            subtitle: 'De 9h00 à 10h30',
            date: selectedDate,
          ),
          _buildScheduleCard(
            title: 'Cours de français',
            subtitle: 'De 11h00 à 12h30',
            date: selectedDate,
          ),
          _buildScheduleCard(
            title: "Cours d'anglais",
            subtitle: 'De 14h00 à 15h30',
            date: selectedDate,
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleCard({
    required String title,
    required String subtitle,
    required DateTime date,
  }) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}
