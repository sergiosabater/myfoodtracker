import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

class FoodEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 200)();
  RealColumn get calories => real()();
  RealColumn get protein => real().nullable()();
  RealColumn get carbs => real().nullable()();
  RealColumn get fats => real().nullable()();
  TextColumn get icon => text().nullable()(); // Emoji
  DateTimeColumn get date => dateTime()();
  TextColumn get time => text().nullable()(); // Hora como string (ej: "14:30")
  TextColumn get notes => text().nullable()();
}

@DriftDatabase(tables: [FoodEntries])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // TODO: Añadiremos migraciones más adelante
}

QueryExecutor _openConnection() {
  return driftDatabase(
    name: 'my_food_tracker',
    native: const DriftNativeOptions(shareAcrossIsolates: true),
  );
}