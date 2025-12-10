import 'package:flutter/material.dart';
import 'package:my_food_tracker/core/theme/app_theme.dart';

class ChartSelector extends StatefulWidget {
  final Function(String) onViewChanged;

  const ChartSelector({
    super.key,
    required this.onViewChanged,
  });

  @override
  State<ChartSelector> createState() => _ChartSelectorState();
}

class _ChartSelectorState extends State<ChartSelector> {
  // 🔥 Eliminada la opción 'Año' y ajustados los textos
  static const List<Map<String, dynamic>> chartTypes = [
    {'id': 'today', 'label': 'Hoy', 'icon': Icons.today},
    {'id': 'week', 'label': 'Semana', 'icon': Icons.calendar_view_week},
    {'id': 'month', 'label': 'Mes', 'icon': Icons.calendar_today},
  ];

  String _selectedChart = 'today';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Text(
            'VISUALIZACIÓN DE DATOS',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey[500],
              letterSpacing: 0.5,
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Selector de periodo con ajustes para evitar overflow
        Container(
          padding: const EdgeInsets.all(4), // 🔥 Reducido de 6
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey, width: 1),
          ),
          child: Row(
            children: chartTypes.map((type) {
              final bool isSelected = _selectedChart == type['id'];

              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0), // 🔥 Reducido de 4.0
                  child: Material(
                    color: isSelected ? AppTheme.surface : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    elevation: isSelected ? 2 : 0,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        setState(() {
                          _selectedChart = type['id'];
                        });
                        widget.onViewChanged(type['id']);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12, // 🔥 Reducido de 14
                          horizontal: 6, // 🔥 Reducido de 8
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: isSelected
                              ? Border.all(
                                  color: AppTheme.primary.withOpacity(0.1),
                                  width: 1.5,
                                )
                              : null,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              type['icon'],
                              size: 16, // 🔥 Reducido de 18
                              color: isSelected
                                  ? AppTheme.primary
                                  : Colors.grey[600],
                            ),
                            const SizedBox(width: 4), // 🔥 Reducido de 8
                            // 🔥 FittedBox para evitar overflow del texto
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                type['label'],
                                style: TextStyle(
                                  fontSize: 13, // 🔥 Reducido de 14
                                  fontWeight: isSelected
                                      ? FontWeight.w700
                                      : FontWeight.w600,
                                  color: isSelected
                                      ? AppTheme.primary
                                      : Colors.grey[600],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 16),
        // Indicador de qué datos se muestran
        _buildDataIndicator(),
      ],
    );
  }

  Widget _buildDataIndicator() {
    // 🔥 Actualizado sin la opción 'year'
    final Map<String, String> infoTexts = {
      'today': 'Calorías por hora • Total: 1,250 kcal',
      'week': 'Cal/día • Promedio: 1,850 kcal',
      'month': 'Total semanal • Tendencia',
    };

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            infoTexts[_selectedChart] ?? '',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[700],
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: _showChartOptions,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.more_horiz_rounded,
                size: 20,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showChartOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Opciones de gráfica',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[800],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_rounded),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              ..._buildChartOptionList(),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildChartOptionList() {
    return [
      _buildOptionItem(
        icon: Icons.bar_chart_rounded,
        label: 'Cambiar a gráfica de barras',
        onTap: () {},
      ),
      _buildOptionItem(
        icon: Icons.download_rounded,
        label: 'Exportar datos (.CSV)',
        onTap: () {},
      ),
      _buildOptionItem(
        icon: Icons.share_rounded,
        label: 'Compartir progreso',
        onTap: () {},
      ),
      _buildOptionItem(
        icon: Icons.settings_rounded,
        label: 'Personalizar gráfica',
        onTap: () {},
      ),
    ];
  }

  Widget _buildOptionItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppTheme.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppTheme.primary),
      ),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Colors.grey[800],
        ),
      ),
      trailing: Icon(
        Icons.chevron_right_rounded,
        color: Colors.grey[400],
      ),
      onTap: onTap,
    );
  }
}