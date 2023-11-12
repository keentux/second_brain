import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:second_brain/core/extension_function.dart';
import 'package:second_brain/core/function_helper.dart';
import 'package:second_brain/presentation/widgets/dividers.dart';

class MyColumn extends StatelessWidget {
  final String? title;
  final double? fontSize;
  final List<Widget>? children;
  final bool showTitle;

  const MyColumn({
    super.key,
    this.title,
    this.children,
    this.fontSize = 18,
    this.showTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (title != null && showTitle)
          Center(
            child: AutoSizeText(
              title!,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onTertiary,
              ),
              maxLines: 1,
            ),
          ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: children ??
                [
                  const SizedBox.shrink(),
                ],
          ),
        ),
      ],
    );
  }
}

class TaskTableWidget extends StatelessWidget {
  final List<Widget>? todoWidgets;
  final List<Widget>? inProgressWidgets;
  final List<Widget>? toReviewWidgets;
  final List<Widget>? doneWidgets;
  final double? titleFontSize;

  const TaskTableWidget({
    super.key,
    this.todoWidgets,
    this.inProgressWidgets,
    this.toReviewWidgets,
    this.doneWidgets,
    this.titleFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Row(
        children: <Widget>[
          Expanded(
            child: MyColumn(
              title: 'To Do',
              fontSize: titleFontSize,
              children: todoWidgets,
            ),
          ),
          MyVerticalDivider(
            color: Theme.of(context).colorScheme.onTertiary,
            identFactor: 5,
          ),
          Expanded(
            child: MyColumn(
              title: 'In Progress',
              fontSize: titleFontSize,
              children: inProgressWidgets,
            ),
          ),
          MyVerticalDivider(
            color: Theme.of(context).colorScheme.onTertiary,
            identFactor: 5,
          ),
          Expanded(
            child: MyColumn(
              title: 'To Review',
              fontSize: titleFontSize,
              children: toReviewWidgets,
            ),
          ),
          MyVerticalDivider(
            color: Theme.of(context).colorScheme.onTertiary,
            identFactor: 5,
          ),
          Expanded(
            child: MyColumn(
              title: 'Done',
              fontSize: titleFontSize,
              children: doneWidgets,
            ),
          ),
        ],
      );
    });
  }
}

class WeekTableWidget extends StatelessWidget {
  final List<Widget>? mondayWidgets;
  final List<Widget>? tuesdayWidgets;
  final List<Widget>? wednesdayWidgets;
  final List<Widget>? thursdayWidgets;
  final List<Widget>? fridayWidgets;
  final List<Widget>? saturdayWidgets;
  final List<Widget>? sundayWidgets;
  final double? titleFontSize;
  final bool showTitle;
  final int? weekNumber;

  const WeekTableWidget({
    super.key,
    this.mondayWidgets,
    this.tuesdayWidgets,
    this.wednesdayWidgets,
    this.thursdayWidgets,
    this.fridayWidgets,
    this.saturdayWidgets,
    this.sundayWidgets,
    this.titleFontSize,
    this.showTitle = true,
    this.weekNumber,
  });

  List<Widget> addDayNbrToWidgets(List<Widget>? list, DateTime date,
      BuildContext context, double? fontSize) {
    DateTime now = DateTime.now();
    List<Widget> newList = List<Widget>.empty(growable: true);
    bool today = date.isDateEqual(now);
    bool isActualMonth = date.isMonthEqual(now);
    newList.add(Center(
      child: Container(
        decoration: today
            ? BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.onTertiary)
            : null,
        child: Padding(
          padding: EdgeInsets.all(today ? 8.0 : 0),
          child: Text(
            date.day.toString(),
            style: TextStyle(
                fontSize: (fontSize != null) ? fontSize * 1.5 : null,
                fontWeight: FontWeight.bold,
                color: today
                    ? Theme.of(context).colorScheme.primary
                    : isActualMonth
                        ? Theme.of(context).colorScheme.tertiary
                        : Theme.of(context).colorScheme.onSecondary),
          ),
        ),
      ),
    ));
    (list != null) ? newList.addAll(list) : null;
    return newList;
  }

  @override
  Widget build(BuildContext context) {
    int weekNbr;
    String actualMonth = DateFormat('MMM').format(DateTime.now()).toString();
    if (weekNumber == null) {
      weekNbr = getWeekNumber(DateTime.now());
    } else {
      weekNbr = weekNumber!;
    }
    List<DateTime> weekDays = getWeekDates(weekNbr);

    return Builder(builder: (context) {
      return Row(
        children: <Widget>[
          Center(
            child: RotatedBox(
              quarterTurns: 3,
              child: Text(
                'Week $weekNbr - $actualMonth',
                style: TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onTertiary,
                ),
              ),
            ),
          ),
          Expanded(
            child: MyColumn(
              title: 'Monday',
              fontSize: titleFontSize,
              showTitle: showTitle,
              children: addDayNbrToWidgets(
                mondayWidgets,
                weekDays[0],
                context,
                titleFontSize,
              ),
            ),
          ),
          MyVerticalDivider(
            color: Theme.of(context).colorScheme.onTertiary,
            identFactor: 5,
          ),
          Expanded(
            child: MyColumn(
              title: 'Tuesday',
              fontSize: titleFontSize,
              showTitle: showTitle,
              children: addDayNbrToWidgets(
                tuesdayWidgets,
                weekDays[1],
                context,
                titleFontSize,
              ),
            ),
          ),
          MyVerticalDivider(
            color: Theme.of(context).colorScheme.onTertiary,
            identFactor: 5,
          ),
          Expanded(
            child: MyColumn(
              title: 'Wednesday',
              fontSize: titleFontSize,
              showTitle: showTitle,
              children: addDayNbrToWidgets(
                wednesdayWidgets,
                weekDays[2],
                context,
                titleFontSize,
              ),
            ),
          ),
          MyVerticalDivider(
            color: Theme.of(context).colorScheme.onTertiary,
            identFactor: 5,
          ),
          Expanded(
            child: MyColumn(
              title: 'Thursday',
              fontSize: titleFontSize,
              showTitle: showTitle,
              children: addDayNbrToWidgets(
                thursdayWidgets,
                weekDays[3],
                context,
                titleFontSize,
              ),
            ),
          ),
          MyVerticalDivider(
            color: Theme.of(context).colorScheme.onTertiary,
            identFactor: 5,
          ),
          Expanded(
            child: MyColumn(
              title: 'Friday',
              fontSize: titleFontSize,
              showTitle: showTitle,
              children: addDayNbrToWidgets(
                fridayWidgets,
                weekDays[4],
                context,
                titleFontSize,
              ),
            ),
          ),
          MyVerticalDivider(
            color: Theme.of(context).colorScheme.onTertiary,
            identFactor: 5,
          ),
          Expanded(
            child: MyColumn(
              title: 'Saturday',
              fontSize: titleFontSize,
              showTitle: showTitle,
              children: addDayNbrToWidgets(
                saturdayWidgets,
                weekDays[5],
                context,
                titleFontSize,
              ),
            ),
          ),
          MyVerticalDivider(
            color: Theme.of(context).colorScheme.onTertiary,
            identFactor: 5,
          ),
          Expanded(
            child: MyColumn(
              title: 'Sunday',
              showTitle: showTitle,
              fontSize: titleFontSize,
              children: addDayNbrToWidgets(
                sundayWidgets,
                weekDays[6],
                context,
                titleFontSize,
              ),
            ),
          ),
        ],
      );
    });
  }
}
