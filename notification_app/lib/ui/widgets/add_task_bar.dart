import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:notification_app/controllers/task_controller.dart';
import 'package:notification_app/models/task.dart';
import 'package:notification_app/ui/theme.dart';
import 'package:notification_app/ui/widgets/custome_buttom.dart';
import 'package:notification_app/ui/widgets/input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskControllers _taskController = Get.put(TaskControllers());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteControlles = TextEditingController();
  String _selectedType = 'Estudios';
  DateTime _selectedDate = DateTime.now();
  // Configura el tiempo actual y agrega una hora para el tiempo de finalización predeterminado
  String _endTime = DateFormat("HH:mm").format(
    DateTime.now().add(const Duration(hours: 1)),
  );

  // Configura el tiempo de inicio en formato de 24 horas
  String _starTime = DateFormat("HH:mm").format(DateTime.now());
  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String _selectedRepeat = "Nunca";
  List<String> repeatList = ["Nunca", "Diario", "Cada Semana", "Cada Mes"];
  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.colorScheme.background,
      appBar: _appBar(context),
      body: Container(
        padding: const EdgeInsets.only(left: 15, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "Añadir tarea",
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lato',
                ),
              ),
              //Titulo
              MyInputField(
                title: "Titulo",
                hint: "Ingrese un titulo",
                controller: _titleController,
              ),
              //nota
              MyInputField(
                title: "Nota",
                hint: "Ingrese una descripcion",
                controller: _noteControlles,
              ),
              //Tipo
              MyInputField(
                title: "Tipo de Tarea",
                hint: _selectedType,
                widget: DropdownButton<String>(
                  value: _selectedType,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedType = newValue ?? _selectedType;
                    });
                  },
                  items: <String>['Estudios', 'Trabajo', 'Salud', 'Personal']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              //fecha
              MyInputField(
                title: "Fecha",
                hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  icon: const Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: _getDateFromUser,
                ),
              ),
              //Tiempo
              Row(
                children: [
                  Expanded(
                    child: MyInputField(
                      title: "Hora de inicio",
                      hint: _starTime,
                      widget: IconButton(
                        onPressed: () => _getTimeFromUser(isStartTime: true),
                        icon: const Icon(
                          Icons.access_time_filled_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: MyInputField(
                      title: "Hora de finalizacion",
                      hint: _endTime,
                      widget: IconButton(
                        onPressed: () => _getTimeFromUser(isStartTime: false),
                        icon: const Icon(
                          Icons.access_time_filled_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              //avisas a x tiempo
              MyInputField(
                title: "Avisar",
                hint: "$_selectedRemind minutos antes",
                widget: DropdownButton<int>(
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Lato',
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                  underline: Container(height: 0),
                  onChanged: (int? newValue) {
                    setState(() {
                      _selectedRemind = newValue ?? _selectedRemind;
                    });
                  },
                  items: remindList.map((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(
                        value.toString(),
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              //repetir
              MyInputField(
                title: "Repetir",
                hint: _selectedRepeat,
                widget: DropdownButton<String>(
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Lato',
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                  underline: Container(height: 0),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRepeat = newValue ?? _selectedRepeat;
                    });
                  },
                  items: repeatList.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 8.0),
              //color
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _colorPallete(),
                  CustomButton(
                    text: 'Agregar',
                    onTap: () => _validate(),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  _validate() {
    DateTime now = DateTime.now();
    DateTime selectedDateTime = _selectedDate.add(Duration(
        hours: int.parse(_starTime.split(":")[0]),
        minutes: int.parse(_starTime.split(":")[1].split(" ")[0])));
    DateTime endDateTime = _selectedDate.add(Duration(
        hours: int.parse(_endTime.split(":")[0]),
        minutes: int.parse(_endTime.split(":")[1].split(" ")[0])));

    if (_titleController.text.isNotEmpty &&
        _noteControlles.text.isNotEmpty &&
        _starTime.isNotEmpty &&
        _endTime.isNotEmpty) {
      /* if (selectedDateTime.isBefore(now)) {
        Get.snackbar(
          "Error",
          "La fecha y hora de inicio deben ser posteriores a la fecha y hora actual",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          icon: Icon(Icons.warning_amber_rounded, color: Colors.white),
        );
      } else 
      if (endDateTime.isBefore(selectedDateTime)) {
        Get.snackbar(
          "Error",
          "La hora de finalización debe ser posterior a la hora de inicio",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          icon: Icon(Icons.warning_amber_rounded, color: Colors.white),
        );
      } else*/
      {
        _addTaskToDb();
        Get.back();
        Get.snackbar(
          "Listo",
          "Tarea agregada exitosamente ",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.greenAccent,
          colorText: Colors.white,
          icon: Icon(Icons.done, color: Colors.white),
        );
      }
    } else {
      Get.snackbar(
        "Requerido",
        "Todos los campos son necesarios",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        icon: Icon(Icons.warning_amber_rounded, color: Colors.white),
      );
    }
  }

  _addTaskToDb() async {
    int value = await _taskController.addTask(
      task: Task(
        title: _titleController.text,
        note: _noteControlles.text,
        tipo: _selectedType,
        date: DateFormat.yMd().format(_selectedDate),
        starTime: _starTime,
        endTime: _endTime,
        reminder: _selectedRemind,
        repeat: _selectedRepeat,
        color: _selectedColor,
        isCompleted: 0,
      ),
    );
    print("Mi id es $value");
    _scheduleAlarm();
  }

  _scheduleAlarm() async {
    // Calcular la hora actual y agregar 5 minutos
    DateTime alarmTime = DateTime.now().add(Duration(minutes: 1));

    // Calcular la diferencia de tiempo entre ahora y la hora de la alarma
    int timeInSeconds = alarmTime.difference(DateTime.now()).inSeconds;

    // Programar la alarma con android_alarm_manager
    await AndroidAlarmManager.oneShot(
      Duration(seconds: timeInSeconds), // Tiempo absoluto hasta la alarma
      0, // ID único para la alarma
      _alarmCallback, // Método que se ejecutará cuando suene la alarma
      wakeup: true,
      // Indica si la alarma debe despertar al dispositivo del modo de suspensión
    );
  }

  void _alarmCallback() {
    print('¡Alarma activada!');
  }

  _colorPallete() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Color",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Lato',
          ),
        ),
        const SizedBox(height: 8.0),
        Wrap(
            children: List<Widget>.generate(3, (int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedColor = index;
                //print(index);
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                radius: 14,
                backgroundColor: index == 0
                    ? primaryClr
                    : index == 1
                        ? pinkClr
                        : yellowClr,
                child: _selectedColor == index
                    ? const Icon(Icons.done, color: Colors.white, size: 16)
                    : Container(),
              ),
            ),
          );
        })),
      ],
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.colorScheme.background,
      leading: GestureDetector(
        onTap: () => Get.back(),
        child: const Icon(
          Icons.arrow_back_ios,
          size: 20,
        ),
      ),
      actions: [
        _taskMenuButton(),
        const SizedBox(width: 20),
      ],
    );
  }

  Widget _taskMenuButton() {
    return PopupMenuButton<int>(
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Row(
            children: [
              const Icon(
                Icons.wb_sunny,
                color: Colors.orange,
              ),
              const SizedBox(width: 10),
              Text('Modo Oscuro'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: Row(
            children: [
              const Icon(
                Icons.task,
                color: Colors.blue,
              ),
              const SizedBox(width: 10),
              Text('Otra tarea'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 3,
          child: Row(
            children: [
              const Icon(
                Icons.task,
                color: Colors.blue,
              ),
              const SizedBox(width: 10),
              Text('Otra tarea más'),
            ],
          ),
        ),
      ],
      onSelected: (value) {
        switch (value) {
          case 1:
            // Lógica para activar el modo oscuro
            break;
          case 2:
            // Lógica para otra tarea
            break;
          case 3:
            // Lógica para otra tarea más
            break;
          default:
        }
      },
    );
  }

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2124));
    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
      });
    } else {
      print("no válido");
    }
  }

  Future<void> _getTimeFromUser({required bool isStartTime}) async {
    TimeOfDay? pickedTime = await _showTimePicker();

    if (pickedTime == null) {
      print("Tiempo cancelado");
    } else {
      String _formattedTime = pickedTime.format(context);
      setState(() {
        if (isStartTime) {
          _starTime = _formattedTime;
        } else {
          _endTime = _formattedTime;
        }
      });
    }
  }

  Future<TimeOfDay?> _showTimePicker() {
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(_starTime.split(":")[0]),
        minute: int.parse(_starTime.split(":")[1].split(" ")[0]),
      ),
    );
  }
}
