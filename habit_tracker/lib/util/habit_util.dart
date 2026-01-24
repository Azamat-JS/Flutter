import 'package:habit_tracker/models/habit.dart';

bool isHabitCompletedToday(List<DateTime> completedDates) {
  final today = DateTime.now();
  return completedDates.any(
    (d) => d.year == today.year && d.month == today.month && d.day == today.day,
  );
}

Map<DateTime, int> prepHeatMapDataset(List<Habit> habits) {
  Map<DateTime, int> dataset = {};
  for (var habit in habits) {
    for (var date in habit.completedDates) {
      final normalizedDate = DateTime(date.year, date.month, date.day);
      if (dataset.containsKey(normalizedDate)) {
        dataset[normalizedDate] = dataset[normalizedDate]! + 1;
      } else {
        dataset[normalizedDate] = 1;
      }
    }
  }
  return dataset;
}
