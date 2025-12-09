import 'package:flutter/material.dart';
import 'package:my_food_tracker/core/theme/app_theme.dart';

class CalorieProgressCard extends StatelessWidget {
  final double consumed;
  final double goal;

  const CalorieProgressCard({
    super.key,
    required this.consumed,
    required this.goal,
  });

  @override
  Widget build(BuildContext context) {
    const double progress = 1.0;
    final double remaining = goal - consumed;
    final Color ringColor = _getProgressColor(progress);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          children: [
            // 🔥 Mitad izquierda: Anillo de progreso
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(right: 12.0), // Separación interna
                child: _buildProgressRing(progress, ringColor),
              ),
            ),
            // 🔥 Mitad derecha: Información detallada
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0), // Separación interna
                child: _buildProgressInfo(progress, remaining, context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressRing(double progress, Color color) {
    // 🔥 Usamos AspectRatio para un círculo responsivo y cuadrado
    return AspectRatio(
      aspectRatio: 1, // Esto fuerza un cuadrado perfecto
      child: Container(
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Anillo de fondo
            SizedBox.expand(
              child: CircularProgressIndicator(
                value: 1.0,
                strokeWidth: 12, // Reducido ligeramente para el nuevo tamaño
                valueColor: AlwaysStoppedAnimation(Colors.grey[200]),
              ),
            ),
            // Anillo de progreso animado
            SizedBox.expand(
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: progress.clamp(0.0, 1.0)),
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeOut,
                builder: (context, value, child) {
                  return CircularProgressIndicator(
                    value: value,
                    strokeWidth: 12,
                    valueColor: AlwaysStoppedAnimation(color),
                    backgroundColor: Colors.transparent,
                  );
                },
              ),
            ),
            // Porcentaje centrado
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${(progress * 100).toStringAsFixed(0)}%',
                  style: const TextStyle(
                    fontSize: 24, // Ajustado para el nuevo tamaño
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
        ),
      ),
    );
  }

  Widget _buildProgressInfo(double progress, double remaining, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center, // 🔥 Centra verticalmente el contenido
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
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '${consumed.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 28, // 🔥 Reducido para caber en el espacio reducido
                  fontWeight: FontWeight.w900,
                  color: AppTheme.primary,
                ),
              ),
              TextSpan(
                text: ' / ${goal.toStringAsFixed(0)} kcal',
                style: TextStyle(
                  fontSize: 18, // 🔥 Reducido para caber en el espacio reducido
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Barra de progreso horizontal
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 8,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation(_getProgressColor(progress)),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Restan',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  '${remaining.toStringAsFixed(0)} kcal',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.secondary,
                  ),
                ),
              ],
            ),
            if (progress > 1.0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.error.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      size: 14,
                      color: AppTheme.error,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Excedido',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.error,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }

  Color _getProgressColor(double progress) {
    if (progress < 0.6) return AppTheme.secondary;
    if (progress < 0.9) return AppTheme.accent;
    return AppTheme.error;
  }
}