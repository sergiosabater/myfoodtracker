import 'package:flutter/material.dart';
import 'package:my_food_tracker/core/theme/app_theme.dart';
import 'package:visibility_detector/visibility_detector.dart';

class CalorieProgressCard extends StatefulWidget {
  final double consumed;
  final double goal;

  const CalorieProgressCard({
    super.key,
    required this.consumed,
    required this.goal,
  });

  @override
  State<CalorieProgressCard> createState() => _CalorieProgressCardState();
}

class _CalorieProgressCardState extends State<CalorieProgressCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _progress = widget.goal > 0 ? widget.consumed / widget.goal : 0.0;

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: _progress.clamp(0.0, 1.0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _restartAnimation() {
    if (_animationController.isCompleted) {
      _animationController.reset();
      _animationController.forward();
    }
  }

  Color _getProgressColor(double progress) {
    if (progress < 0.6) return AppTheme.secondary;
    if (progress < 0.9) return AppTheme.accent;
    return AppTheme.error;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          children: [
            // Mitad izquierda: Anillo de progreso
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: _buildProgressRing(),
              ),
            ),
            // Mitad derecha: Información simplificada
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: _buildProgressInfo(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressRing() {
    const String ringKey = 'progress-ring';

    return VisibilityDetector(
      key: const Key(ringKey),
      onVisibilityChanged: (VisibilityInfo info) {
        if (info.visibleFraction > 0.5) {
          _restartAnimation();
        }
      },
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          alignment: Alignment.center,
          child: AnimatedBuilder(
            animation: _progressAnimation,
            builder: (context, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox.expand(
                    child: CircularProgressIndicator(
                      value: 1.0,
                      strokeWidth: 12,
                      valueColor: AlwaysStoppedAnimation(Colors.grey[200]),
                    ),
                  ),
                  SizedBox.expand(
                    child: CircularProgressIndicator(
                      value: _progressAnimation.value,
                      strokeWidth: 12,
                      valueColor: AlwaysStoppedAnimation(
                        _getProgressColor(_progress),
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${(_progress * 100).toStringAsFixed(0)}%',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.primary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Progreso',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildProgressInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'OBJETIVO DIARIO',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.grey[500],
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 12),
        // 🔥 SOLUCIÓN: FittedBox para evitar overflow
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                widget.consumed.toStringAsFixed(0),
                style: const TextStyle(
                  fontSize: 28, // Reducido de 34
                  fontWeight: FontWeight.w900,
                  color: AppTheme.primary,
                ),
              ),
              const SizedBox(width: 2),
              Text(
                '/',
                style: TextStyle(
                  fontSize: 22, // Reducido de 24
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(width: 2),
              Text(
                widget.goal.toStringAsFixed(0),
                style: TextStyle(
                  fontSize: 24, // Reducido de 28
                  fontWeight: FontWeight.w700,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(width: 2),
              Text(
                'kcal',
                style: TextStyle(
                  fontSize: 16, // Reducido de 18
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: _progress >= 1.0
                ? AppTheme.error.withOpacity(0.08)
                : AppTheme.secondary.withOpacity(0.08),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                _progress >= 1.0
                    ? Icons.warning_amber_rounded
                    : Icons.arrow_downward_rounded,
                size: 16,
                color: _progress >= 1.0 ? AppTheme.error : AppTheme.secondary,
              ),
              const SizedBox(width: 6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _progress >= 1.0 ? 'Excedido' : 'Restan',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${(widget.goal - widget.consumed).abs().toStringAsFixed(0)} kcal',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: _progress >= 1.0
                          ? AppTheme.error
                          : AppTheme.secondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
