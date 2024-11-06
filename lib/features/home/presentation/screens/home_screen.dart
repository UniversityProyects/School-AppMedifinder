import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:medifinder_crm/features/shared/shared.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      appBar: AppBar(
        title: const Text('Principal'),
      ),
      body: const _HomeVista(),
    );
  }
}

class _HomeVista extends StatelessWidget {
  const _HomeVista();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Citas médicas realizadas este mes',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: _getPieChartSections(),
                  borderData: FlBorderData(show: false),
                  centerSpaceRadius: 40,
                ),
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'Citas por especialidad este mes',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 15,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          switch (value.toInt()) {
                            case 0:
                              return const Text('Cardio',
                                  style: TextStyle(color: Colors.black));
                            case 1:
                              return const Text('Neuro',
                                  style: TextStyle(color: Colors.black));
                            case 2:
                              return const Text('Gineco',
                                  style: TextStyle(color: Colors.black));
                            case 3:
                              return const Text('Pedia',
                                  style: TextStyle(color: Colors.black));
                            case 4:
                              return const Text('Derma',
                                  style: TextStyle(color: Colors.black));
                            default:
                              return const Text('');
                          }
                        },
                      ),
                    ),
                    leftTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: _getStyledBarGroups(),
                  gridData: const FlGridData(show: false),
                  backgroundColor: const Color(0xFF2A2D3E),
                ),
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'Mejores calificaciones',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 10, // Max rating value is 5
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          switch (value.toInt()) {
                            case 0:
                              return const Text('Erick',
                                  style: TextStyle(color: Colors.black));
                            case 1:
                              return const Text('Carlos',
                                  style: TextStyle(color: Colors.black));
                            case 2:
                              return const Text('Jessica',
                                  style: TextStyle(color: Colors.black));
                            default:
                              return const Text('');
                          }
                        },
                      ),
                    ),
                    leftTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: _getRatingBarGroups(),
                  gridData: FlGridData(show: false),
                  backgroundColor: const Color(0xFF2A2D3E),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> _getPieChartSections() {
    final List<Map<String, dynamic>> data = [
      {"Id_Medico": 19, "Nombre_Medico": "Carlos", "Total_Citas": 15},
      {"Id_Medico": 5, "Nombre_Medico": "Daniel", "Total_Citas": 5},
      {"Id_Medico": 1, "Nombre_Medico": "Erick", "Total_Citas": 8},
    ];

    return data.map((entry) {
      final color = _getColor(entry['Id_Medico']);
      return PieChartSectionData(
        value: entry['Total_Citas'].toDouble(),
        title: '${entry['Nombre_Medico']} \n${entry['Total_Citas']}',
        color: color,
        radius: 60,
        titleStyle:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      );
    }).toList();
  }

  Color _getColor(int idMedico) {
    switch (idMedico) {
      case 19:
        return Colors.teal.shade200;
      case 5:
        return Colors.teal.shade500;
      case 1:
        return Colors.teal.shade900;
      default:
        return Colors.grey;
    }
  }

  List<BarChartGroupData> _getStyledBarGroups() {
    final List<Map<String, dynamic>> data = [
      {
        "Id_Especialidad": 1,
        "Nombre_Especialidad": "Cardiologia",
        "Total_Citas": 5
      },
      {
        "Id_Especialidad": 2,
        "Nombre_Especialidad": "Neurologia",
        "Total_Citas": 1
      },
      {
        "Id_Especialidad": 3,
        "Nombre_Especialidad": "Ginecologia",
        "Total_Citas": 4
      },
      {
        "Id_Especialidad": 4,
        "Nombre_Especialidad": "Pediatria",
        "Total_Citas": 6
      },
      {
        "Id_Especialidad": 5,
        "Nombre_Especialidad": "Dermatologia",
        "Total_Citas": 5
      },
    ];

    const colorGradient = LinearGradient(
      colors: [Colors.tealAccent, Colors.teal],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
    );

    return data.asMap().entries.map((entry) {
      int index = entry.key;
      final item = entry.value;

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: item['Total_Citas'].toDouble(),
            gradient: colorGradient,
            width: 12,
            borderRadius: BorderRadius.circular(8),
          ),
        ],
        showingTooltipIndicators: [0],
      );
    }).toList();
  }

  List<BarChartGroupData> _getRatingBarGroups() {
    final List<Map<String, dynamic>> data = [
      {"Id_Medico": 19, "Nombre_Medico": "Erick", "Calificacion": 2.89},
      {"Id_Medico": 18, "Nombre_Medico": "Carlos", "Calificacion": 4},
      {"Id_Medico": 16, "Nombre_Medico": "Daniel", "Calificacion": 1},
    ];

    const colorGradient = LinearGradient(
      colors: [Colors.tealAccent, Colors.teal],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
    );

    return data.asMap().entries.map((entry) {
      int index = entry.key;
      final item = entry.value;

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: item['Calificacion'].toDouble(),
            gradient: colorGradient,
            width: 12,
            borderRadius: BorderRadius.circular(8),
          ),
        ],
        showingTooltipIndicators: [0],
      );
    }).toList();
  }
}
