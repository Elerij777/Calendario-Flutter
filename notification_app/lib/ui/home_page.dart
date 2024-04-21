import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:intl/intl.dart';
import 'package:notification_app/ui/services/notification_services.dart';
import 'package:notification_app/ui/services/theme_services.dart';
import 'package:notification_app/ui/theme.dart';
import 'package:notification_app/ui/widgets/add_task_bar.dart';
import 'package:notification_app/ui/widgets/custome_buttom.dart';

//import 'package:notification_app/ui/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final NotifyHelper notifyHelper;

  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();

    // Solicitar permisos de notificación para iOS y Android
    notifyHelper.requestIOSPermissions();
    notifyHelper.requestAndroidPermissions();
    notifyHelper.initializeNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: context.theme.colorScheme.background,
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  margin:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat.yMMMMd('es').format(DateTime.now()),
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 95, 95, 95),
                              fontFamily: 'Lato',
                            ),
                          ),
                          Localizations.override(
                            context: context,
                            locale: const Locale('es'),
                            child: const Text(
                              "Hoy",
                              style: TextStyle(
                                fontSize: 28.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Lato',
                              ),
                            ),
                          ),
                        ],
                      ),
                      CustomButton(
                        text: '+ Agregar Tarea',
                        onTap: () => Get.to(const AddTaskPage()),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
/*
//2 calendario extenso
          Localizations.override(
            context: context,
            locale: const Locale('es'),
            child: Builder(
              builder: (context) {
                return CalendarDatePicker(
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                  onDateChanged: (value) {},
                );
              },
            ),
          ),
*/
          _addTaskBar(),
          _addDateBar(),
        ],
      ),
    );
  }

//calendario
  _addDateBar() {
    //calendario del video
    return Container(
      margin: const EdgeInsets.only(top: 20.0, left: 5, bottom: 20.0),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: primaryClr,
        selectedTextColor: Colors.white,
        //dia
        dayTextStyle: const TextStyle(
          fontFamily: 'Lato',
        ),
        //fecha
        dateTextStyle: const TextStyle(
          fontFamily: 'Lato',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
        //mes
        monthTextStyle: const TextStyle(
          fontFamily: 'Lato',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
        locale: 'es', // Establecer el idioma a español
        onDateChange: (date) {},
      ),
    );
  }

  _addTaskBar() {
    return Container();
  }

//parte superior de la app
  _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.colorScheme.background,
      leading: GestureDetector(
        onTap: () {
          ThemeService().switchTheme();
          notifyHelper.displayNotification(
            title: "¡Hola!",
            body: Get.isDarkMode
                ? "Modo oscuro activado."
                : "Modo claro activado.",
          );
        },
        child: Icon(
          Get.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round,
          size: 20,
        ),
      ),
      title: Text(
        _saludo(),
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).textTheme.bodyText1?.color,
        ),
      ),
      actions: [
        CircleAvatar(
          backgroundImage: AssetImage("assets/images/profile.jpg"),
        ),
        SizedBox(width: 20),
      ],
    );
  }

  String _saludo() {
    var hora = DateTime.now().hour;
    if (hora >= 5 && hora < 12) {
      return "¡Buenos días!";
    } else if (hora >= 12 && hora < 18) {
      return "¡Buenas tardes!";
    } else {
      return "¡Buenas noches!";
    }
  }
}
