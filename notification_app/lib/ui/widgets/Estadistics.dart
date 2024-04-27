import 'dart:core';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:notification_app/db/db_helper.dart';
import 'package:notification_app/models/task.dart';

class EstadisticaScreen extends StatefulWidget {
  const EstadisticaScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EstadisticaScreenState createState() => _EstadisticaScreenState();
}

class _EstadisticaScreenState extends State<EstadisticaScreen> {
  int _completedTasks = 0;
  int _incompleteTasks = 0;
  int _estudiosTasks = 0;
  int _trabajoTasks = 0;
  int _saludTasks = 0;
  int _personalTasks = 0;
  double _semana1Minutos = 0.0;
  double _semana2Minutos = 0.0;
  double _semana3Minutos = 0.0;
  double _semana4Minutos = 0.0;
  double _semana5Minutos = 0.0;
  late double tiempototal5semanas = 0.0;

  List<String> _weekLabels = [];
  List<int> _timeSpentData = [];

  void _showChart(String chartName) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        if (chartName == 'completedTasks') {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Estadísticas de tareas completas'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  width: 200,
                  height: 210,
                  child: CustomPaint(
                    size: const Size(200, 200),
                    painter: PieChartPainter(
                      percentages: [
                        _completedTasks /
                            (_completedTasks + _incompleteTasks),
                        _incompleteTasks /
                            (_completedTasks + _incompleteTasks),
                      ],
                      colors: [Colors.green, Colors.red],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildLegend(
                      "Incompletas ${(_incompleteTasks / (_completedTasks + _incompleteTasks) * 100).toStringAsFixed(1)}%",
                      Colors.red),
                  _buildLegend(
                      'Completadas ${(_completedTasks / (_completedTasks + _incompleteTasks) * 100).toStringAsFixed(1)}%',
                      Colors.green),
                ],
              ),
            ],
          );
        } else if (chartName == 'taskTypes') {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Tareas completadas por tipo'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  width: 200,
                  height: 210,
                  child: CustomPaint(
                    size: const Size(200, 200),
                    painter: PieChartPainter(
                      percentages: [
                        _estudiosTasks / _completedTasks,
                        _trabajoTasks / _completedTasks,
                        _saludTasks / _completedTasks,
                        _personalTasks / _completedTasks,
                      ],
                      colors: [
                        Colors.blue,
                        Colors.orange,
                        Colors.red,
                        Colors.purple,
                      ],
                    ),
                  ),
                ),
              ),
              Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildLegend(
                        'Estudios ${(_estudiosTasks / _completedTasks * 100).toStringAsFixed(1)}%',
                        Colors.blue),
                    _buildLegend(
                        'Trabajo ${(_trabajoTasks / _completedTasks * 100).toStringAsFixed(1)}%',
                        Colors.orange),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildLegend(
                        'Salud ${(_saludTasks / _completedTasks * 100).toStringAsFixed(1)}%',
                        Colors.red),
                    _buildLegend(
                        'Personal ${(_personalTasks / _completedTasks * 100).toStringAsFixed(1)}%',
                        Colors.purple),
                  ],
                )
              ]),
            ],
          );
        } else if (chartName == 'lastFiveWeeks') {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Últimas 5 semanas'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  width: 200,
                  height: 210,
                  child: CustomPaint(
                    size: const Size(200, 200),
                    painter: PieChartPainter(
                      percentages: [
                        _semana1Minutos / tiempototal5semanas,
                        _semana2Minutos / tiempototal5semanas,
                        _semana3Minutos / tiempototal5semanas,
                        _semana4Minutos / tiempototal5semanas,
                        _semana5Minutos / tiempototal5semanas,
                      ],
                      colors: [
                        Colors.blue,
                        Colors.orange,
                        Colors.red,
                        Colors.purple,
                        Colors.green,
                      ],
                    ),
                  ),
                ),
              ),
              Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildLegend(
                      'Semana 1: ${_semana1Minutos.toStringAsFixed(2)} minutos',
                      Colors.blue,
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _buildLegend(
                        'Semana 2: ${_semana2Minutos.toStringAsFixed(2)} minutos',
                        Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    _buildLegend(
                        'Semana 3: ${_semana3Minutos.toStringAsFixed(2)} minutos',
                        Colors.red),
                  ],
                ),
                Row(
                  children: [
                    _buildLegend(
                        'Semana 4: ${_semana4Minutos.toStringAsFixed(2)} minutos',
                        Colors.purple),
                  ],
                ),
                Row(
                  children: [
                    _buildLegend(
                        'Semana 5: ${_semana5Minutos.toStringAsFixed(2)} minutos',
                        Colors.green),
                  ],
                )
              ]),const SizedBox(height: 10),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() async {
    _loadCompletedTaskStats();
    await _loadTimeSpentLastFiveWeeks();
  }

  Future<void> _loadTimeSpentLastFiveWeeks() async {
    DateTime currentDate = DateTime.now();
    DateTime fiveWeeksAgo = currentDate.subtract(const Duration(days: 5 * 7));

    List<Task> tasks = await DBHelper.queryTasks();
    double semana1Minutos = 0.0;
    double semana2Minutos = 0.0;
    double semana3Minutos = 0.0;
    double semana4Minutos = 0.0;
    double semana5Minutos = 0.0;

    tasks.forEach((task) {
      String formattedDate =
          '${task.date.split('/')[2]}-${task.date.split('/')[0].padLeft(2, '0')}-${task.date.split('/')[1].padLeft(2, '0')}';
      DateTime endTime = DateTime.parse("$formattedDate ${task.endTime}");

      if (task.isCompleted == 1 && endTime.isAfter(fiveWeeksAgo)) {
        DateTime taskWeek = _getStartOfWeek(endTime);
        int taskDuration = _calculateTaskDuration(task);

        if (taskWeek.isAtSameMomentAs(currentDate)) {
          semana1Minutos += taskDuration;
        } else if (taskWeek.add(const Duration(days: 7)).isAfter(currentDate)) {
          semana2Minutos += taskDuration;
        } else if (taskWeek.add(const Duration(days: 14)).isAfter(currentDate)) {
          semana3Minutos += taskDuration;
        } else if (taskWeek.add(const Duration(days: 21)).isAfter(currentDate)) {
          semana4Minutos += taskDuration;
        } else {
          semana5Minutos += taskDuration;
        }
      }
    });

    setState(() {
      _semana1Minutos = semana1Minutos;
      _semana2Minutos = semana2Minutos;
      _semana3Minutos = semana3Minutos;
      _semana4Minutos = semana4Minutos;
      _semana5Minutos = semana5Minutos;
      tiempototal5semanas = semana1Minutos +
          semana2Minutos +
          semana3Minutos +
          semana4Minutos +
          semana5Minutos;
    });
  }

  DateTime _getStartOfWeek(DateTime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }

  int _calculateTaskDuration(Task task) {
    DateTime startTime = DateTime(
      int.parse(task.date.split('/')[2]), // Año
      int.parse(task.date.split('/')[0]), // Mes
      int.parse(task.date.split('/')[1]), // Día
      int.parse(task.starTime.split(':')[0]), // Hora
      int.parse(task.starTime.split(':')[1]), // Minuto
    );

    DateTime endTime = DateTime(
      int.parse(task.date.split('/')[2]), // Año
      int.parse(task.date.split('/')[0]), // Mes
      int.parse(task.date.split('/')[1]), // Día
      int.parse(task.endTime.split(':')[0]), // Hora
      int.parse(task.endTime.split(':')[1]), // Minuto
    );

    return endTime.difference(startTime).inMinutes;
  }

  DateTime _getEndOfWeek(DateTime date) {
    int currentWeekday = date.weekday;

    int difference = 7 - currentWeekday;
    return date.add(Duration(days: difference));
  }

  void _loadCompletedTaskStats() async {
    List<Task> tasks = await DBHelper.queryTasks();
    int completedCount = tasks.where((task) => task.isCompleted == 1).length;
    int incompleteCount = tasks.length - completedCount;
    int estudiosCount = tasks
        .where((task) => task.tipo == 'Estudios' && task.isCompleted == 1)
        .length;
    int trabajoCount = tasks
        .where((task) => task.tipo == 'Trabajo' && task.isCompleted == 1)
        .length;
    int saludCount = tasks
        .where((task) => task.tipo == 'Salud' && task.isCompleted == 1)
        .length;
    int personalCount = tasks
        .where((task) => task.tipo == 'Personal' && task.isCompleted == 1)
        .length;

    setState(() {
      _completedTasks = completedCount;
      _incompleteTasks = incompleteCount;
      _estudiosTasks = estudiosCount;
      _trabajoTasks = trabajoCount;
      _saludTasks = saludCount;
      _personalTasks = personalCount;
    });
  }

  Widget _buildLegend(String text, Color color) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          color: color,
        ),
        const SizedBox(width: 8),
        Text(text),
      ],
    );
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Estadísticas'),
    ),
    body: SingleChildScrollView(
      reverse: true,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton(
                  context,
                  'Tareas completadas',
                  Colors.green,
                  () {
                    _showChart('completedTasks');
                  },
                ),
                _buildButton(
                  context,
                  'Últimas 5 semanas',
                  Colors.purple,
                  () {
                    _showChart('lastFiveWeeks');
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton(
                  context,
                  'Tareas completadas por tipo',
                  Colors.blue,
                  () {
                    _showChart('taskTypes');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildButton(BuildContext context, String text, Color color, Function onPressed) {
  return ElevatedButton(
    onPressed: () => onPressed(),
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white, backgroundColor: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 60,
      ),
    ),
    child: Text(text),
  );
}
}

class PieChartPainter extends CustomPainter {
final List<double> percentages;
  final List<Color> colors;

  PieChartPainter({
    required this.percentages,
    required this.colors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);

    final paint = Paint()..style = PaintingStyle.fill;

    double startAngle = -pi / 2;
    double endAngle = 0.0;

    for (int i = 0; i < percentages.length; i++) {
      paint.color = colors[i];
      endAngle = startAngle + 2 * pi * percentages[i];
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        endAngle - startAngle,
        true,
        paint,
      );
      startAngle = endAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}