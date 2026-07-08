import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_food_tracker/core/theme/app_theme.dart';
import 'package:my_food_tracker/features/home/presentation/providers/home_provider.dart';
import 'package:my_food_tracker/features/food_log/data/repositories/food_log_repository.dart';
import 'package:my_food_tracker/presentation/widgets/calorie_progress_card.dart';
import 'package:my_food_tracker/presentation/widgets/scan_food_button.dart';
import 'package:my_food_tracker/presentation/widgets/chart_selector.dart';
import 'package:my_food_tracker/presentation/widgets/food_list.dart';
import 'package:marquee/marquee.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final double dailyGoal = 2000.0;

  @override
  Widget build(BuildContext context) {
    final foodRepository = ref.watch(foodLogRepositoryProvider);

    // Datos hardcodeados temporalmente (los reemplazaremos pronto)
    final consumedToday = 1250.0;
    final todayFoods = [
      {'name': 'Manzana', 'calories': 95, 'time': '08:30', 'icon': '🍎'},
      {'name': 'Sándwich de pavo', 'calories': 320, 'time': '13:15', 'icon': '🥪'},
    ];

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        surfaceTintColor: Colors.transparent,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'MyFoodTracker',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
                color: Colors.black87,
              ),
            ),
            _SimpleMarquee(
              date: DateTime.now(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                    fontSize: 16,
                  ),
            ),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.insights_outlined), onPressed: () {}),
          IconButton(icon: const Icon(Icons.settings_outlined), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            CalorieProgressCard(
              consumed: consumedToday,
              goal: dailyGoal,
            ),
            const SizedBox(height: 24),
            const ScanFoodButton(),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ChartSelector(
                onViewChanged: (viewType) {},
              ),
            ),
            const SizedBox(height: 24),
            // Placeholder de gráfica
            Container(
              height: 200,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Text('Gráfica - Próximamente con fl_chart'),
              ),
            ),
            const SizedBox(height: 32),
            FoodList(foods: todayFoods),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

// Mantén la clase _SimpleMarquee igual que antes
class _SimpleMarquee extends StatefulWidget {
  final DateTime date;
  final TextStyle? style;

  const _SimpleMarquee({required this.date, this.style});

  @override
  State<_SimpleMarquee> createState() => _SimpleMarqueeState();
}

class _SimpleMarqueeState extends State<_SimpleMarquee> {
  late String _formattedDate;

  @override
  void initState() {
    super.initState();
    _formattedDate = _formatDate(widget.date);
  }

  bool _checkTextOverflow(String text, TextStyle style, double maxWidth) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size.width > maxWidth;
  }

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = widget.style ?? const TextStyle(color: Colors.grey, fontSize: 16);

    return SizedBox(
      height: 24,
      width: 280.0,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final shouldScroll = _checkTextOverflow(_formattedDate, effectiveStyle, constraints.maxWidth);
          if (shouldScroll) {
            return Marquee(
              text: _formattedDate,
              style: effectiveStyle,
              scrollAxis: Axis.horizontal,
              blankSpace: constraints.maxWidth,
              velocity: 30.0,
              pauseAfterRound: Duration.zero,
            );
          } else {
            return Text(_formattedDate, style: effectiveStyle, overflow: TextOverflow.ellipsis);
          }
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    // ... (mantén tu implementación original de formato de fecha)
    final weekday = ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'][date.weekday - 1];
    final month = ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'][date.month - 1];
    return '$weekday, ${date.day} de $month de ${date.year}';
  }
}