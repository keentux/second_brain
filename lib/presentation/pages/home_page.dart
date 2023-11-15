import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:second_brain/core/task_feature/task_status_enum.dart';
import 'package:second_brain/domain/entities/task_entity.dart';
import 'package:second_brain/presentation/cubit/task_cubit.dart';
import 'package:second_brain/presentation/widgets/agenda_widgets.dart';
import 'package:second_brain/presentation/widgets/card.dart';
import 'package:second_brain/presentation/widgets/table.dart';
import 'package:second_brain/presentation/widgets/weather_widget.dart';
import 'package:second_brain/presentation/widgets/welcome_widget.dart';
import 'package:second_brain/themes/color.dart';

class ResumeTasksWidget extends StatelessWidget {
  const ResumeTasksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const TaskTableWidget(
      summarize: true,
    );
  }
}

class StatusTasksWidget extends StatelessWidget {
  const StatusTasksWidget({super.key});

  bool _verticalPosition(BoxConstraints constraints) {
    return (constraints.maxWidth < max(constraints.maxHeight, 300));
  }

  @override
  Widget build(BuildContext context) {
    List<Color> pieColor = [
      myAccentTint5Color,
      myAccentTint3Color,
      myAccentTint1Color,
    ];

    return BlocBuilder<TaskCubit, List<TaskEntity>?>(
      builder: (context, taskState) {
        int? todoTaskCount = taskState
            ?.where((element) => element.status == TaskStatusEnum.todo)
            .length;
        int? inProgressTasksCount = taskState
            ?.where((element) => element.status == TaskStatusEnum.inprogress)
            .length;
        int? inReviewTasksCount = taskState
            ?.where((element) => element.status == TaskStatusEnum.inreview)
            .length;
        Map<String, double> statusMap = {
          "In Review": inReviewTasksCount?.toDouble() ?? 0,
          "In Progress": inProgressTasksCount?.toDouble() ?? 0,
          "To Do": todoTaskCount?.toDouble() ?? 0,
        };

        return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return PieChart(
            dataMap: statusMap,
            colorList: pieColor,
            animationDuration: const Duration(milliseconds: 1000),
            initialAngleInDegree: -90,
            chartLegendSpacing: 20,
            legendOptions: _verticalPosition(constraints)
                ? const LegendOptions(
                    legendPosition: LegendPosition.bottom,
                    legendTextStyle: TextStyle(fontWeight: FontWeight.normal),
                  )
                : const LegendOptions(
                    legendPosition: LegendPosition.right,
                    legendTextStyle: TextStyle(fontWeight: FontWeight.bold),
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
      },
    );
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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
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
