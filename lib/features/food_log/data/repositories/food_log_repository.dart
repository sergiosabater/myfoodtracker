import 'package:my_food_tracker/features/food_log/data/database/app_database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'food_log_repository.g.dart';

@Riverpod(keepAlive: true)
class FoodLogRepository extends _$FoodLogRepository {
  final AppDatabase _db = AppDatabase();

  @override
  Future<List<FoodEntry>> build() async {
    return [];
  }

  Future<int> insertFood(FoodEntriesCompanion entry) async {
    return await _db.into(_db.foodEntries).insert(entry);
  }

  Future<bool> deleteFood(int id) async {
    final count = await (_db.delete(_db.foodEntries)..where((tbl) => tbl.id.equals(id))).go();
    return count > 0;
  }

  Future<List<FoodEntry>> getTodayEntries() async {
    return [];
  }

  Stream<List<FoodEntry>> watchTodayEntries() {
    return Stream.value([]);
  }
}