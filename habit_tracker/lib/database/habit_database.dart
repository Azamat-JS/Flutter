import 'package:flutter/material.dart';
import 'package:habit_tracker/models/app_settings.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class HabitDatabase extends ChangeNotifier {
  static late Isar isar;

  static Future<void> initilize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([
      HabitSchema,
      AppSettingsSchema,
    ], directory: dir.path);
  }

  Future<void> saveFirstLaunchDate() async {
    final existingSettings = await isar.appSettings.where().findFirst();
    if (existingSettings == null) {
      final newSettings = AppSettings()..firstLaunchDate = DateTime.now();
      await isar.writeTxn(() => isar.appSettings.put(newSettings));
    }
  }

  Future<DateTime?> getFirstLaunchDate() async {
    final settings = await isar.appSettings.where().findFirst();
    return settings?.firstLaunchDate;
  }

  final List<Habit> currentHabits = [];

  Future<void> addHabit(String habitName) async {
    final newHabit = Habit()..name = habitName;
    await isar.writeTxn(() => isar.habits.put(newHabit));
    readHabits();
  }

  Future<void> readHabits() async {
    List<Habit> fetchHabits = await isar.habits.where().findAll();
    currentHabits.clear();
    currentHabits.addAll(fetchHabits);
    notifyListeners();
  }

  Future<void> updateHabitCompletion(int id, bool isCompleted) async {
    final habit = await isar.habits.get(id);
    if (habit == null) return;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    if (isCompleted && !habit.completedDates.contains(today)) {
      habit.completedDates.add(today);
    } else if (!isCompleted) {
      habit.completedDates.removeWhere(
        (d) =>
            d.year == today.year &&
            d.month == today.month &&
            d.day == today.day,
      );
    }
    await isar.writeTxn(() => isar.habits.put(habit));
    await readHabits();
  }

  Future<void> updateHabitName(int id, String newName) async {
    final habit = await isar.habits.get(id);
    if (habit == null) return;

    habit.name = newName;
    await isar.writeTxn(() => isar.habits.put(habit));
    await readHabits();
  }

  Future<void> deleteHabit(int id) async {
    await isar.writeTxn(() => isar.habits.delete(id));
    await readHabits();
  }
}
