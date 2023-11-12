import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:second_brain/presentation/widgets/agenda_widgets.dart';
import 'package:second_brain/presentation/widgets/card.dart';
import 'package:second_brain/presentation/widgets/table.dart';
import 'package:second_brain/presentation/widgets/weather_widget.dart';
import 'package:second_brain/presentation/widgets/welcome_widget.dart';
import 'package:second_brain/themes/color.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class ResumeTasksWidget extends StatelessWidget {
  const ResumeTasksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    //Todo: Get tasks from database and parse from status
    // ----
    List<MyTitledCard> toDoCards = <MyTitledCard>[
      MyTitledCard(
        'task to do',
        color: Theme.of(context).colorScheme.outline,
      ),
      MyTitledCard(
        'Second task to do',
        color: Theme.of(context).colorScheme.outline,
      ),
    ];
    List<MyTitledCard> inProgressCards = <MyTitledCard>[
      MyTitledCard(
        'Create the project',
        color: Theme.of(context).colorScheme.outline,
      ),
    ];
    List<MyTitledCard> doneCards = <MyTitledCard>[
      MyTitledCard(
        'Start the app',
        color: Theme.of(context).colorScheme.outline,
      ),
    ];
    // ----
    return TaskTableWidget(
      todoWidgets: toDoCards,
      inProgressWidgets: inProgressCards,
      doneWidgets: doneCards,
    );
  }
}

class StatusTasksWidget extends StatelessWidget {
  const StatusTasksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, double> statusTasks = {
      "In Review": 1,
      "In Progress": 2,
      "To Do": 5,
    };
    List<Color> pieColor = [
      myAccentTint5Color,
      myAccentTint3Color,
      myAccentTint1Color,
    ];
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return PieChart(
        dataMap: statusTasks,
        colorList: pieColor,
        animationDuration: const Duration(milliseconds: 1000),
        initialAngleInDegree: -90,
        chartLegendSpacing: 20,
        legendOptions: LegendOptions(
          legendPosition: (constraints.maxWidth < constraints.maxHeight)
              ? LegendPosition.bottom
              : LegendPosition.right,
          legendTextStyle: TextStyle(
            fontWeight: (constraints.maxWidth < constraints.maxHeight)
                ? FontWeight.normal
                : FontWeight.bold,
          ),
        ),
        chartValuesOptions: ChartValuesOptions(
          chartValueStyle: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
          showChartValueBackground: false,
          showChartValues: true,
          showChartValuesInPercentage: true,
          showChartValuesOutside: false,
          decimalPlaces: 1,
        ),
      );
    });
  }
}

class AgendaResumeWidget extends StatelessWidget {
  const AgendaResumeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const WeekTableWidget(
      tuesdayWidgets: [
        AgendaMeetingWidget(
          start: '10h30',
          end: '12h00',
          title: 'Team Meeting',
        ),
        AgendaTaskWidget(
          title: 'Task to do',
        ),
      ],
      wednesdayWidgets: [
        AgendaTaskWidget(
          title: 'Create the project',
        ),
      ],
    );
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(height: 10),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: WelcomeWidget(),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: MyCard(
                    elevated: true,
                    child: WeatherWidget(),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: MyCard(
                    elevated: true,
                    child: ResumeTasksWidget(),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: MyCard(
                    elevated: true,
                    child: StatusTasksWidget(),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: MyCard(
                    elevated: true,
                    child: AgendaResumeWidget(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
