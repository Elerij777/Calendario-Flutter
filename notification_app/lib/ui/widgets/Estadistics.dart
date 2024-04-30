// ignore: file_names
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
  double _week1Minutes = 0.0;
  double _week2Minutes = 0.0;
  double _week3Minutes = 0.0;
  double _week4Minutes = 0.0;
  double _week5Minutes = 0.0;
  double _week6Minutes = 0.0;
  double totalSixWeeksTime = 0.0;
  String fechaActual = DateTime.now().toString().split(' ')[0];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() async {
    _loadCompletedTaskStats();
    await _loadTimeSpentLastFiveWeeks();
    _loadTimeSpentNextSixWeeks();
  }

  Future<void> _loadTimeSpentNextSixWeeks() async {
    //print('La fecha actual es: $fechaActual');

    List<Task> tasks = await DBHelper.queryTasks();
    double week1Minutes = 0.0;
    double week2Minutes = 0.0;
    double week3Minutes = 0.0;
    double week4Minutes = 0.0;
    double week5Minutes = 0.0;
    double week6Minutes = 0.0;

    tasks.forEach((task) {
      /*
      print(task.date +
          ' y ' +
          fechaActual +
          ' y ' +
          obtenerFechaIncrementada(fechaActual, 1));
      print('la fecha es: ' + obtenerFechaIncrementada(fechaActual, 0));
*/
      if (task.date == obtenerFechaIncrementada(fechaActual, 0) ||
          task.date == obtenerFechaIncrementada(fechaActual, 1) ||
          task.date == obtenerFechaIncrementada(fechaActual, 2) ||
          task.date == obtenerFechaIncrementada(fechaActual, 3) ||
          task.date == obtenerFechaIncrementada(fechaActual, 4) ||
          task.date == obtenerFechaIncrementada(fechaActual, 5) ||
          task.date == obtenerFechaIncrementada(fechaActual, 6)) {
        week1Minutes += calcularDistanciaEnMinutos(
          int.parse(task.endTime.split(':')[0]),
          int.parse(task.endTime.split(':')[1]),
          int.parse(task.starTime.split(':')[0]),
          int.parse(task.starTime.split(':')[1]),
        );
        //print('llego al primer if');
      } else if (task.date == obtenerFechaIncrementada(fechaActual, 7) ||
          task.date == obtenerFechaIncrementada(fechaActual, 8) ||
          task.date == obtenerFechaIncrementada(fechaActual, 9) ||
          task.date == obtenerFechaIncrementada(fechaActual, 10) ||
          task.date == obtenerFechaIncrementada(fechaActual, 11) ||
          task.date == obtenerFechaIncrementada(fechaActual, 12) ||
          task.date == obtenerFechaIncrementada(fechaActual, 13)) {
        week1Minutes += calcularDistanciaEnMinutos(
          int.parse(task.endTime.split(':')[0]),
          int.parse(task.endTime.split(':')[1]),
          int.parse(task.starTime.split(':')[0]),
          int.parse(task.starTime.split(':')[1]),
        );
        //print('llego al segundo if');
      } else if (task.date == obtenerFechaIncrementada(fechaActual, 14) ||
          task.date == obtenerFechaIncrementada(fechaActual, 15) ||
          task.date == obtenerFechaIncrementada(fechaActual, 16) ||
          task.date == obtenerFechaIncrementada(fechaActual, 17) ||
          task.date == obtenerFechaIncrementada(fechaActual, 18) ||
          task.date == obtenerFechaIncrementada(fechaActual, 19) ||
          task.date == obtenerFechaIncrementada(fechaActual, 20)) {
        week1Minutes += calcularDistanciaEnMinutos(
          int.parse(task.endTime.split(':')[0]),
          int.parse(task.endTime.split(':')[1]),
          int.parse(task.starTime.split(':')[0]),
          int.parse(task.starTime.split(':')[1]),
        );
        //print('llego al tercer if');
      } else if (task.date == obtenerFechaIncrementada(fechaActual, 21) ||
          task.date == obtenerFechaIncrementada(fechaActual, 22) ||
          task.date == obtenerFechaIncrementada(fechaActual, 23) ||
          task.date == obtenerFechaIncrementada(fechaActual, 24) ||
          task.date == obtenerFechaIncrementada(fechaActual, 25) ||
          task.date == obtenerFechaIncrementada(fechaActual, 26) ||
          task.date == obtenerFechaIncrementada(fechaActual, 27)) {
        week1Minutes += calcularDistanciaEnMinutos(
          int.parse(task.endTime.split(':')[0]),
          int.parse(task.endTime.split(':')[1]),
          int.parse(task.starTime.split(':')[0]),
          int.parse(task.starTime.split(':')[1]),
        );
        //print('llego al cuarto if');
      } else if (task.date == obtenerFechaIncrementada(fechaActual, 28) ||
          task.date == obtenerFechaIncrementada(fechaActual, 29) ||
          task.date == obtenerFechaIncrementada(fechaActual, 30) ||
          task.date == obtenerFechaIncrementada(fechaActual, 31) ||
          task.date == obtenerFechaIncrementada(fechaActual, 32) ||
          task.date == obtenerFechaIncrementada(fechaActual, 33) ||
          task.date == obtenerFechaIncrementada(fechaActual, 34)) {
        week1Minutes += calcularDistanciaEnMinutos(
          int.parse(task.endTime.split(':')[0]),
          int.parse(task.endTime.split(':')[1]),
          int.parse(task.starTime.split(':')[0]),
          int.parse(task.starTime.split(':')[1]),
        );
        //print('llego al quinto if');
      } else if (task.date == obtenerFechaIncrementada(fechaActual, 35) ||
          task.date == obtenerFechaIncrementada(fechaActual, 36) ||
          task.date == obtenerFechaIncrementada(fechaActual, 37) ||
          task.date == obtenerFechaIncrementada(fechaActual, 38) ||
          task.date == obtenerFechaIncrementada(fechaActual, 39) ||
          task.date == obtenerFechaIncrementada(fechaActual, 40) ||
          task.date == obtenerFechaIncrementada(fechaActual, 41)) {
        week1Minutes += calcularDistanciaEnMinutos(
          int.parse(task.endTime.split(':')[0]),
          int.parse(task.endTime.split(':')[1]),
          int.parse(task.starTime.split(':')[0]),
          int.parse(task.starTime.split(':')[1]),
        );
        //print('llego al sexto if');
      }
    });

    setState(() {
      _week1Minutes = week1Minutes;
      _week2Minutes = week2Minutes;
      _week3Minutes = week3Minutes;
      _week4Minutes = week4Minutes;
      _week5Minutes = week5Minutes;
      _week6Minutes = week6Minutes;
      totalSixWeeksTime = week1Minutes +
          week2Minutes +
          week3Minutes +
          week4Minutes +
          week5Minutes +
          week6Minutes;
    });
  }

  int calcularDistanciaEnMinutos(
      int hora1, int minuto1, int hora2, int minuto2) {
    //print("hora1: $hora1, minuto1: $minuto1, hora2: $hora2, minuto2: $minuto2");
    // Convierte cada hora a minutos
    int minutos1 = hora1 * 60 + minuto1;
    int minutos2 = hora2 * 60 + minuto2;
    //print("minutos1: $minutos1, minutos2: $minutos2");

    // Calcula la diferencia en minutos
    int distanciaEnMinutos = (minutos2 - minutos1).abs();
    //("Distancia en minutos: $distanciaEnMinutos");

    return distanciaEnMinutos;
  }

  String obtenerFechaIncrementada(String fechaString, int dias) {
    List<String> partes = fechaString.split('-');

    // Verificar si la cadena tiene el formato esperado
    if (partes.length != 3) {
      return 'Formato de fecha incorrecto';
    }

    int anio = int.parse(partes[0]);
    int mes = int.parse(partes[1]);
    int dia = int.parse(partes[2]);

    DateTime fecha = DateTime(anio, mes, dia);
    DateTime fechaIncrementada = fecha.add(Duration(days: dias));

    return '${fechaIncrementada.month}/${fechaIncrementada.day}/${fechaIncrementada.year}';
  }

  Future<void> _loadTimeSpentLastFiveWeeks() async {
    DateTime currentDate = DateTime.now();

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

      if (task.isCompleted == 1) {
        DateTime taskWeek = _getStartOfWeek(endTime);
        int taskDuration = _calculateTaskDuration(task);

        if (task.date == obtenerFechaIncrementada(fechaActual, 0) ||
            task.date == obtenerFechaIncrementada(fechaActual, -1) ||
            task.date == obtenerFechaIncrementada(fechaActual, -2) ||
            task.date == obtenerFechaIncrementada(fechaActual, -3) ||
            task.date == obtenerFechaIncrementada(fechaActual, -4) ||
            task.date == obtenerFechaIncrementada(fechaActual, -5) ||
            task.date == obtenerFechaIncrementada(fechaActual, -6)) {
          semana1Minutos += calcularDistanciaEnMinutos(
            int.parse(task.endTime.split(':')[0]),
            int.parse(task.endTime.split(':')[1]),
            int.parse(task.starTime.split(':')[0]),
            int.parse(task.starTime.split(':')[1]),
          );
        } else if (task.date == obtenerFechaIncrementada(fechaActual, -7) ||
            task.date == obtenerFechaIncrementada(fechaActual, -8) ||
            task.date == obtenerFechaIncrementada(fechaActual, -9) ||
            task.date == obtenerFechaIncrementada(fechaActual, -10) ||
            task.date == obtenerFechaIncrementada(fechaActual, -11) ||
            task.date == obtenerFechaIncrementada(fechaActual, -12) ||
            task.date == obtenerFechaIncrementada(fechaActual, -13)) {
          semana2Minutos += calcularDistanciaEnMinutos(
            int.parse(task.endTime.split(':')[0]),
            int.parse(task.endTime.split(':')[1]),
            int.parse(task.starTime.split(':')[0]),
            int.parse(task.starTime.split(':')[1]),
          );
        } else if (task.date == obtenerFechaIncrementada(fechaActual, -14) ||
            task.date == obtenerFechaIncrementada(fechaActual, -15) ||
            task.date == obtenerFechaIncrementada(fechaActual, -16) ||
            task.date == obtenerFechaIncrementada(fechaActual, -17) ||
            task.date == obtenerFechaIncrementada(fechaActual, -18) ||
            task.date == obtenerFechaIncrementada(fechaActual, -19) ||
            task.date == obtenerFechaIncrementada(fechaActual, -20)) {
          semana3Minutos += calcularDistanciaEnMinutos(
            int.parse(task.endTime.split(':')[0]),
            int.parse(task.endTime.split(':')[1]),
            int.parse(task.starTime.split(':')[0]),
            int.parse(task.starTime.split(':')[1]),
          );
        } else if (task.date == obtenerFechaIncrementada(fechaActual, -21) ||
            task.date == obtenerFechaIncrementada(fechaActual, -22) ||
            task.date == obtenerFechaIncrementada(fechaActual, -23) ||
            task.date == obtenerFechaIncrementada(fechaActual, -24) ||
            task.date == obtenerFechaIncrementada(fechaActual, -25) ||
            task.date == obtenerFechaIncrementada(fechaActual, -26) ||
            task.date == obtenerFechaIncrementada(fechaActual, -27)) {
          semana4Minutos += calcularDistanciaEnMinutos(
            int.parse(task.endTime.split(':')[0]),
            int.parse(task.endTime.split(':')[1]),
            int.parse(task.starTime.split(':')[0]),
            int.parse(task.starTime.split(':')[1]),
          );
        } else if (task.date == obtenerFechaIncrementada(fechaActual, -28) ||
            task.date == obtenerFechaIncrementada(fechaActual, -29) ||
            task.date == obtenerFechaIncrementada(fechaActual, -30) ||
            task.date == obtenerFechaIncrementada(fechaActual, -31) ||
            task.date == obtenerFechaIncrementada(fechaActual, -32) ||
            task.date == obtenerFechaIncrementada(fechaActual, -33) ||
            task.date == obtenerFechaIncrementada(fechaActual, -34)) {
          semana5Minutos += calcularDistanciaEnMinutos(
            int.parse(task.endTime.split(':')[0]),
            int.parse(task.endTime.split(':')[1]),
            int.parse(task.starTime.split(':')[0]),
            int.parse(task.starTime.split(':')[1]),
          );
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
                  'Tareas por tipo',
                  Colors.blue,
                  () {
                    _showChart('taskTypes');
                  },
                ),
                _buildButton(
                  context,
                  'Próximas 6 semanas',
                  Colors.orange,
                  () {
                    _showChart('nextSixWeeks');
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

  Widget _buildButton(
      BuildContext context, String text, Color color, Function onPressed) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: color,
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
                        _completedTasks / (_completedTasks + _incompleteTasks),
                        _incompleteTasks / (_completedTasks + _incompleteTasks),
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
                _buildLegend(
                  'Semana 1: ${_semana1Minutos.toStringAsFixed(2)} minutos',
                  Colors.blue,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _buildLegend(
                        'Semana 2: ${_semana2Minutos.toStringAsFixed(2)} minutos',
                        Colors.orange),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _buildLegend(
                        'Semana 3: ${_semana3Minutos.toStringAsFixed(2)} minutos',
                        Colors.red),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _buildLegend(
                        'Semana 4: ${_semana4Minutos.toStringAsFixed(2)} minutos',
                        Colors.purple),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _buildLegend(
                        'Semana 5: ${_semana5Minutos.toStringAsFixed(2)} minutos',
                        Colors.green),
                  ],
                )
              ]),
              const SizedBox(height: 10),
            ],
          );
        } else if (chartName == 'nextSixWeeks') {
          return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text('Proximas 6 semanas'),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                    width: 200,
                    height: 210,
                    child: CustomPaint(
                        size: const Size(200, 200),
                        painter: PieChartPainter(percentages: [
                          _week1Minutes / totalSixWeeksTime,
                          _week2Minutes / totalSixWeeksTime,
                          _week3Minutes / totalSixWeeksTime,
                          _week4Minutes / totalSixWeeksTime,
                          _week5Minutes / totalSixWeeksTime,
                          _week6Minutes / totalSixWeeksTime,
                        ], colors: [
                          Colors.blue,
                          Colors.orange,
                          Colors.red,
                          Colors.purple,
                          Colors.green,
                          Colors.yellow,
                        ])))),
            _buildLegend(
              'Semana 1: ${_week1Minutes.toStringAsFixed(2)} minutos',
              Colors.blue,
            ),
            const SizedBox(height: 10),
            _buildLegend(
              'Semana 2: ${_week2Minutes.toStringAsFixed(2)} minutos',
              Colors.orange,
            ),
            const SizedBox(height: 10),
            _buildLegend(
              'Semana 3: ${_week3Minutes.toStringAsFixed(2)} minutos',
              Colors.red,
            ),
            const SizedBox(height: 10),
            _buildLegend(
              'Semana 4: ${_week4Minutes.toStringAsFixed(2)} minutos',
              Colors.purple,
            ),
            const SizedBox(height: 10),
            _buildLegend(
              'Semana 5: ${_week5Minutes.toStringAsFixed(2)} minutos',
              Colors.green,
            ),
            const SizedBox(height: 10),
            _buildLegend(
              'Semana 6: ${_week6Minutes.toStringAsFixed(2)} minutos',
              Colors.yellow,
            ),
            const SizedBox(height: 10),
          ]);
        } else {
          return const SizedBox.shrink();
        }
      },
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
