import 'package:flutter/material.dart';
import 'package:my_food_tracker/core/theme/app_theme.dart';
import 'package:my_food_tracker/presentation/widgets/calorie_progress_card.dart';
import 'package:my_food_tracker/presentation/widgets/chart_selector.dart';
import 'package:my_food_tracker/presentation/widgets/food_list.dart';
import 'package:my_food_tracker/presentation/widgets/scan_food_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Datos de ejemplo para el MVP
  final double dailyGoal = 2000.0;
  final double consumedToday = 1250.0;
  final List<Map<String, dynamic>> todayFoods = [
    {'name': 'Manzana', 'calories': 95, 'time': '08:30', 'icon': '🍎'},
    {'name': 'Sándwich de pavo', 'calories': 320, 'time': '13:15', 'icon': '🥪'},
    {'name': 'Yogur griego', 'calories': 150, 'time': '11:00', 'icon': '🥛'},
    {'name': 'Ensalada César', 'calories': 450, 'time': '14:45', 'icon': '🥗'},
    {'name': 'Batido proteico', 'calories': 235, 'time': '18:20', 'icon': '🥤'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('MyFoodTracker'),
            Text(
              'Hoy, ${_formatDate(DateTime.now())}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.insights_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Tarjeta de progreso diario
            CalorieProgressCard(
              consumed: consumedToday,
              goal: dailyGoal,
            ),
            
            const SizedBox(height: 24),
            
            // Botón principal para escanear comida
            const ScanFoodButton(),
            
            const SizedBox(height: 32),
            
            // Selector de gráficas
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ChartSelector(
                onViewChanged: (viewType) {
                  // Cambiar gráfica según selección
                },
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Gráfica de líneas (placeholder por ahora)
            Container(
              height: 200,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.bar_chart_outlined,
                      size: 48,
                      color: Colors.grey[300],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Gráfica de calorías por horas',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '(Se integrará fl_chart en el siguiente paso)',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Lista de alimentos del día
            FoodList(foods: todayFoods),
            
            const SizedBox(height: 80), // Espacio para el FAB
          ],
        ),
      ),
      // Botón flotante para añadir manualmente
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navegar a pantalla de añadir manualmente
        },
        icon: const Icon(Icons.add),
        label: const Text('Añadir manual'),
        backgroundColor: AppTheme.primary,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
  
  String _formatDate(DateTime date) {
    return '${date.day} de ${_getMonthName(date.month)} de ${date.year}';
  }
  
  String _getMonthName(int month) {
    const months = [
      'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
      'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
    ];
    return months[month - 1];
  }
}