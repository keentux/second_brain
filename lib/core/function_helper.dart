int getWeekNumber(DateTime date) {
  final firstJan = DateTime(date.year, 1, 1);
  return (date.difference(firstJan).inDays / 7).ceil();
}

/// Get week dates from the week number
/// ...
List<DateTime> getWeekDates(int weekNbr) {
  int month, weekMonth, dayNbr, weekDay, mondayNbr, actualYear;
  DateTime monDate;
  actualYear = DateTime.now().year;
  month = (weekNbr / 4).floor();
  // int maxDaysMonth = DateTimeRange(
  //         start: DateTime(actualYear, month),
  //         end: DateTime((month == 12) ? actualYear + 1 : actualYear,
  //             (month == 12) ? 1 : month + 1))
  //     .duration
  //     .inDays;
  weekMonth = weekNbr - (month * 4);
  dayNbr = weekMonth * 7;
  weekDay = DateTime(actualYear, month, dayNbr).weekday;
  mondayNbr = dayNbr + DateTime.monday.compareTo(weekDay);
  monDate = DateTime(actualYear, month, mondayNbr);

  return <DateTime>[
    monDate,
    monDate.add(const Duration(days: 1)),
    monDate.add(const Duration(days: 2)),
    monDate.add(const Duration(days: 3)),
    monDate.add(const Duration(days: 4)),
    monDate.add(const Duration(days: 5)),
    monDate.add(const Duration(days: 6)),
  ];
}
