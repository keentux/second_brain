import 'package:flutter/material.dart';
import 'package:second_brain/core/function_helper.dart';
import 'package:second_brain/presentation/widgets/agenda_widgets.dart';
import 'package:second_brain/presentation/widgets/table.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({super.key});

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: WeekTableWidget(
            weekNumber: getWeekNumber(
              DateTime.now().subtract(const Duration(days: 7)),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: WeekTableWidget(
            showTitle: false,
            tuesdayWidgets: const [
              AgendaMeetingWidget(
                start: '10h30',
                end: '12h00',
                title: 'Team Meeting',
              ),
              AgendaTaskWidget(
                title: 'Task to do',
              )
            ],
            wednesdayWidgets: const [
              AgendaTaskWidget(
                title: 'Create the project',
              ),
            ],
            weekNumber: getWeekNumber(DateTime.now()),
          ),
        ),
        Expanded(
          flex: 1,
          child: WeekTableWidget(
            showTitle: false,
            weekNumber: getWeekNumber(
              DateTime.now().add(const Duration(days: 7)),
            ),
          ),
        ),
      ],
    );
  }
}
