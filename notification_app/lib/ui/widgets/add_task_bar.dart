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
                title: "Title",
                hint: "Enter your Title",
                controller: _titleController,
              ),
              //nota
              MyInputField(
                title: "Note",
                hint: "Enter your note",
                controller: _noteControlles,
              ),
              //fecha
              MyInputField(
                title: "Date",
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
                      title: "Start Time",
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
                      title: "End Time",
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
            ],
          ),
        ),
      ),
    );
  }

  _validate() {
    if (_titleController.text.isNotEmpty && _noteControlles.text.isNotEmpty) {
      _addTaskToDb();
      // Acción a realizar si ambos campos están llenos, como agregar a la base de datos
      Get.back(); // Regresar a la pantalla anterior después de la acción
    } else {
      // Si uno de los campos está vacío, mostrar un mensaje de advertencia
      Get.snackbar(
        "Requerido",
        "El título y la nota son necesarios",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent, // Cambio de color para indicar error
        colorText: Colors.white, // Para mayor legibilidad
        icon: const Icon(Icons.warning_amber_rounded,
            color: Colors.white), // Icono de advertencia
      );
    }
  }

  _addTaskToDb() async {
    int value = await _taskController.addTask(
      task: Task(
        title: _titleController.text,
        note: _noteControlles.text,
        date: DateFormat.yMd().format(_selectedDate),
        starTime: _starTime,
        endTime: _endTime,
        reminder: _selectedRemind,
        repeat: _selectedRepeat,
        color: _selectedColor,
        isCompleted: 0,
      ),
    );
    print("mi id es $value");
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

  _appBar(BuildContext context) {
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
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage("assets/images/profile.jpg"),
        ),
        SizedBox(
          width: 20,
        ),
      ],
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