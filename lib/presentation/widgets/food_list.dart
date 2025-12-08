import 'package:flutter/material.dart';
import 'package:my_food_tracker/core/theme/app_theme.dart';

class FoodList extends StatefulWidget {
  final List<Map<String, dynamic>> foods;

  const FoodList({
    super.key,
    required this.foods,
  });

  @override
  State<FoodList> createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  late List<Map<String, dynamic>> _foods;

  @override
  void initState() {
    super.initState();
    _foods = List.from(widget.foods);
  }

  void _removeFoodItem(int index) {
    // Animación de eliminación
    setState(() {
      final removedItem = _foods.removeAt(index);

      // Mostrar snackbar con opción de deshacer
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('"${removedItem['name']}" eliminado'),
          action: SnackBarAction(
            label: 'Deshacer',
            textColor: AppTheme.secondary,
            onPressed: () {
              setState(() {
                _foods.insert(index, removedItem);
              });
            },
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    });
  }

  void _addManualEntry() {
    // TODO: Navegar a pantalla de añadir alimento manualmente
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Añadir alimento'),
        content: const Text(
            'Esta pantalla se implementará para añadir alimentos manualmente.'),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ALIMENTOS DE HOY',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[500],
                  letterSpacing: 0.5,
                ),
              ),
              Badge.count(
                count: _foods.length,
                largeSize: 22,
                backgroundColor: AppTheme.primary,
                textColor: Colors.white,
              ),
            ],
          ),
        ),

        if (_foods.isEmpty)
          // Estado vacío
          _buildEmptyState()
        else
          // Lista de alimentos
          ..._buildFoodList(),

        // Botón para añadir manualmente
        _buildAddManualButton(),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: Column(
        children: [
          Icon(
            Icons.fastfood_outlined,
            size: 48,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Text(
            'No hay alimentos registrados hoy',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Usa el botón de escanear o añade manualmente',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildFoodList() {
    return List.generate(_foods.length, (index) {
      final food = _foods[index];
      final calories = food['calories'];
      final time = food['time'];

      return Dismissible(
        key: ValueKey(food['name'] + index.toString()),
        direction: DismissDirection.endToStart,
        background: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          padding: const EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
            color: AppTheme.error.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          alignment: Alignment.centerRight,
          child: const Icon(
            Icons.delete_outline_rounded,
            color: AppTheme.error,
            size: 28,
          ),
        ),
        confirmDismiss: (direction) async {
          // Confirmación antes de eliminar
          return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Eliminar alimento'),
              content: Text(
                  '¿Seguro que quieres eliminar "${food['name']}" de tu registro?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    'Cancelar',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text(
                    'Eliminar',
                    style: TextStyle(color: AppTheme.error),
                  ),
                ),
              ],
            ),
          );
        },
        onDismissed: (direction) => _removeFoodItem(index),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          child: Material(
            color: AppTheme.surface,
            borderRadius: BorderRadius.circular(16),
            elevation: 0,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                // TODO: Mostrar detalles/editar alimento
                _showFoodDetails(food);
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: Row(
                  children: [
                    // Emoji/Icono del alimento
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: _getFoodColor(food['icon']),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        food['icon'] ?? '🍽️',
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Información del alimento
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            food['name'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time_rounded,
                                size: 14,
                                color: Colors.grey[500],
                              ),
                              const SizedBox(width: 4),
                              Text(
                                time ?? 'Sin hora',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Calorías y acciones
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '$calories kcal',
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.primary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        SizedBox(
                          height: 24,
                          child: OutlinedButton.icon(
                            onPressed: () {
                              // TODO: Acción rápida (editar, duplicar, etc.)
                            },
                            icon: Icon(
                              Icons.more_horiz_rounded,
                              size: 16,
                              color: Colors.grey[600],
                            ),
                            label: Text(
                              'Más',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 0,
                              ),
                              side: BorderSide(
                                color: Colors.grey[300]!,
                                width: 1,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildAddManualButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 12, left: 20, right: 20),
      child: OutlinedButton.icon(
        onPressed: _addManualEntry,
        icon: const Icon(
          Icons.add_circle_outline_rounded,
          color: AppTheme.primary,
        ),
        label: const Text(
          'Añadir alimento manualmente',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppTheme.primary,
          ),
        ),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          side: BorderSide(
            color: AppTheme.primary.withOpacity(0.3),
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          backgroundColor: AppTheme.primary.withOpacity(0.03),
        ),
      ),
    );
  }

  void _showFoodDetails(Map<String, dynamic> food) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.7,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    width: 60,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: _getFoodColor(food['icon']),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        food['icon'] ?? '🍽️',
                        style: const TextStyle(fontSize: 32),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            food['name'],
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'Añadido a las ${food['time']}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                // Placeholder para información nutricional detallada
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        size: 40,
                        color: Colors.grey[300],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Información nutricional detallada',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Se mostrarán proteínas, carbohidratos, grasas, etc. cuando se integre con la API de IA.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () => Navigator.pop(context),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text('Cerrar'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Color _getFoodColor(String emoji) {
    // Asigna colores basados en el tipo de alimento (por emoji)
    if (emoji.contains('🍎') || emoji.contains('🍌') || emoji.contains('🥝')) {
      return const Color(0xFFFFF0E6); // Naranja claro (frutas)
    } else if (emoji.contains('🥪') ||
        emoji.contains('🍔') ||
        emoji.contains('🌮')) {
      return const Color(0xFFE6F3FF); // Azul claro (comida rápida)
    } else if (emoji.contains('🥗') ||
        emoji.contains('🥦') ||
        emoji.contains('🥒')) {
      return const Color(0xFFE6F9E6); // Verde claro (verduras)
    } else if (emoji.contains('🥛') ||
        emoji.contains('🧀') ||
        emoji.contains('🥚')) {
      return const Color(0xFFFFF6E6); // Amarillo claro (lácteos)
    } else {
      return const Color(0xFFF5F5F5); // Gris claro (por defecto)
    }
  }
}
