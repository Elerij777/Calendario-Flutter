import 'dart:math';

import 'package:flutter/material.dart';
import 'package:notification_app/db/db_helper.dart';
import 'package:notification_app/models/task.dart';

class EstadisticaScreen extends StatefulWidget {
  @override
  _EstadisticaScreenState createState() => _EstadisticaScreenState();
}

class _EstadisticaScreenState extends State<EstadisticaScreen> {
  int _completedTasks = 0;
  int _incompleteTasks = 0;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() async {
    List<Task> tasks = await DBHelper.queryTasks();
    int completedCount = tasks.where((task) => task.isCompleted == 1).length;
    int incompleteCount = tasks.length - completedCount;
    setState(() {
      _completedTasks = completedCount;
      _incompleteTasks = incompleteCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estadísticas'),
      ),
      body: Center(
        child: _completedTasks == 0 && _incompleteTasks == 0
            ? CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 4,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: Text('Estadísticas de tareas completas'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: SizedBox(
                          width: 200,
                          height: 210,
                          child: CustomPaint(
                            size: Size(200, 200),
                            painter: PieChartPainter(
                              completePercent: _completedTasks /
                                  (_completedTasks + _incompleteTasks),
                              completeColor: Colors.green,
                              incompleteColor: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildLegend('Incompletas', Colors.red),
                          _buildLegend('Completadas', Colors.green),
                        ],
                      ),
                      Container(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildLegend(String text, Color color) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          color: color,
        ),
        SizedBox(width: 8),
        Text(text),
      ],
    );
  }
}

class PieChartPainter extends CustomPainter {
  final double completePercent;
  final Color completeColor;
  final Color incompleteColor;

  PieChartPainter({
    required this.completePercent,
    required this.completeColor,
    required this.incompleteColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);

    final paint = Paint()..style = PaintingStyle.fill;

    // Dibujar la parte completa del pastel
    paint.color = completeColor;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * completePercent,
      true,
      paint,
    );

    // Dibujar la parte incompleta del pastel
    paint.color = incompleteColor;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      2 * pi * completePercent - pi / 2,
      2 * pi * (1 - completePercent),
      true,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}




/*
import 'package:flutter/material.dart';
import 'package:notification_app/db/db_helper.dart';
import 'package:notification_app/models/task.dart';
import 'package:community_charts_flutter/pie_chart.dart';

class EstadisticaScreen extends StatefulWidget {
  @override
  _EstadisticaScreenState createState() => _EstadisticaScreenState();
}

class _EstadisticaScreenState extends State<EstadisticaScreen> {
  int _completedTasks = 0;
  int _incompleteTasks = 0;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() async {
    List<Task> tasks = await DBHelper.queryTasks();
    int completedCount = tasks.where((task) => task.isCompleted == 1).length;
    int incompleteCount = tasks.length - completedCount;
    setState(() {
      _completedTasks = completedCount;
      _incompleteTasks = incompleteCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estadísticas'),
      ),
      body: Center(
        child: _completedTasks == 0 && _incompleteTasks == 0
            ? CircularProgressIndicator()
            : PieChart(
                data: [
                  PieChartSectionData(
                    value: _completedTasks.toDouble(),
                    title: 'Completadas',
                    color: Colors.green,
                  ),
                  PieChartSectionData(
                    value: _incompleteTasks.toDouble(),
                    title: 'Incompletas',
                    color: Colors.red,
                  ),
                ],
                legendPosition: LegendPosition.bottom,
                legendTextStyle: TextStyle(color: Colors.black),
              ),
      ),
    );
  }
}



*/