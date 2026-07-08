import 'package:my_food_tracker/features/food_log/data/database/app_database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'food_log_repository.g.dart';

@Riverpod(keepAlive: true)
class FoodLogRepository extends _$FoodLogRepository {
  @override
  Future<List<FoodEntry>> build() async {
    // Datos de prueba para asegurar que se muestren
    final now = DateTime.now();
    return [
      FoodEntry(id: 1, name: 'Manzana', calories: 95, date: now, time: '08:30', icon: '🍎'),
      FoodEntry(id: 2, name: 'Sándwich de pavo', calories: 320, date: now, time: '13:15', icon: '🥪'),
      FoodEntry(id: 3, name: 'Yogur griego', calories: 150, date: now, time: '11:00', icon: '🥛'),
      FoodEntry(id: 4, name: 'Ensalada César', calories: 450, date: now, time: '14:45', icon: '🥗'),
      FoodEntry(id: 5, name: 'Batido proteico', calories: 235, date: now, time: '18:20', icon: '🥤'),
    ];
  }
}