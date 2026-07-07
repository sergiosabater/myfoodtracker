import 'package:flutter/material.dart';
import 'package:my_food_tracker/core/theme/app_theme.dart';
import 'package:shimmer/shimmer.dart';

class ScanFoodButton extends StatefulWidget {
  const ScanFoodButton({super.key});

  @override
  State<ScanFoodButton> createState() => _ScanFoodButtonState();
}

class _ScanFoodButtonState extends State<ScanFoodButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.03), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.03, end: 1.0), weight: 50),
    ]).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onScanPressed() {
    // TODO: Navegar a la pantalla de escaneo con cámara (Fase 2)
    // Por ahora, mostramos un diálogo de placeholder
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Función en desarrollo'),
        content: const Text(
            'Esta función se implementará en la Fase 2. Por ahora, puedes añadir alimentos manualmente.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: InkWell(
            onTap: _onScanPressed,
            borderRadius: BorderRadius.circular(24),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: AppTheme.primaryGradient,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primary.withValues(alpha:0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Efecto glossy en el icono
                  Shimmer.fromColors(
                    baseColor: Colors.white.withValues(alpha:0.9),
                    highlightColor: Colors.white,
                    period: const Duration(seconds: 2),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha:0.2),
                      ),
                      child: const Icon(
                        Icons.camera_alt_rounded,
                        size: 48,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'ESCANEAR COMIDA',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Toma una foto para analizar calorías automáticamente',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}