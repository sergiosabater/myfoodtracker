import 'package:flutter/material.dart';
import 'package:my_food_tracker/core/theme/app_theme.dart';
import 'package:my_food_tracker/presentation/widgets/calorie_progress_card.dart';
import 'package:my_food_tracker/presentation/widgets/scan_food_button.dart';
import 'package:my_food_tracker/presentation/widgets/chart_selector.dart';
import 'package:my_food_tracker/presentation/widgets/food_list.dart';
import 'package:marquee/marquee.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final double dailyGoal = 2000.0;
  final double consumedToday = 1250.0;
  final List<Map<String, dynamic>> todayFoods = [
    {'name': 'Manzana', 'calories': 95, 'time': '08:30', 'icon': '🍎'},
    {
      'name': 'Sándwich de pavo',
      'calories': 320,
      'time': '13:15',
      'icon': '🥪'
    },
    {'name': 'Yogur griego', 'calories': 150, 'time': '11:00', 'icon': '🥛'},
    {'name': 'Ensalada César', 'calories': 450, 'time': '14:45', 'icon': '🥗'},
    {'name': 'Batido proteico', 'calories': 235, 'time': '18:20', 'icon': '🥤'},
  ];

  @override
  Widget build(BuildContext context) {
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
            const SizedBox(height: 4),
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
          IconButton(
            icon: const Icon(Icons.insights_outlined),
            iconSize: 26,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            iconSize: 26,
            padding: const EdgeInsets.only(right: 16, left: 8),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(
            height: 1,
            thickness: 1,
            color: Colors.grey[200],
          ),
        ),
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
            Container(
              height: 200,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
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
            FoodList(foods: todayFoods),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _SimpleMarquee extends StatefulWidget {
  final DateTime date;
  final TextStyle? style;

  const _SimpleMarquee({
    required this.date,
    this.style,
  });

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
    final effectiveStyle = widget.style ??
        const TextStyle(
          color: Colors.grey,
          fontSize: 16,
        );

    return SizedBox(
      height: 24,
      width: 280.0,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final shouldScroll = _checkTextOverflow(
              _formattedDate, effectiveStyle, constraints.maxWidth);

          if (shouldScroll) {
            return Marquee(
              text: _formattedDate,
              style: effectiveStyle,
              scrollAxis: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.center,
              blankSpace: constraints.maxWidth,
              velocity: 30.0,
              pauseAfterRound: Duration.zero,
            );
          } else {
            return Text(
              _formattedDate,
              style: effectiveStyle,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            );
          }
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    final weekday = _getWeekdayName(date.weekday);
    final day = date.day;
    final month = _getMonthName(date.month);
    final year = date.year;
    return '$weekday, $day de $month de $year';
  }

  String _getWeekdayName(int weekday) {
    const weekdays = [
      'Lunes',
      'Martes',
      'Miércoles',
      'Jueves',
      'Viernes',
      'Sábado',
      'Domingo'
    ];
    return weekdays[weekday - 1];
  }

  String _getMonthName(int month) {
    const months = [
      'Enero',
      'Febrero',
      'Marzo',
      'Abril',
      'Mayo',
      'Junio',
      'Julio',
      'Agosto',
      'Septiembre',
      'Octubre',
      'Noviembre',
      'Diciembre'
    ];
    return months[month - 1];
  }
}
