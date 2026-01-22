bool isHabitCompletedToday(List<DateTime> completedDates) {
  final today = DateTime.now();
  return completedDates.any(
    (d) => d.year == today.year && d.month == today.month && d.day == today.day,
  );
}
