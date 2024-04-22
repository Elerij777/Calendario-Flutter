import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:intl/intl.dart';
import 'package:notification_app/controllers/task_controller.dart';
import 'package:notification_app/models/task.dart';
import 'package:notification_app/ui/services/notification_services.dart';
import 'package:notification_app/ui/services/theme_services.dart';
import 'package:notification_app/ui/theme.dart';
import 'package:notification_app/ui/widgets/add_task_bar.dart';
import 'package:notification_app/ui/widgets/custome_buttom.dart';
import 'package:notification_app/ui/widgets/tasttile.dart';

//import 'package:notification_app/ui/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _taskController = Get.put(TaskControllers());
  late final NotifyHelper notifyHelper;
  
  get subHeadingStyle => null;


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
                        onTap: ()async{
                          await Get.to(() => AddTaskPage());
                        _taskController.getTasks();
                        },
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
          SizedBox(height: 10,),
          _showTasks(),
        ],
      ),
    );
  }

  _showTasks(){
return Expanded(
child: Obx((){
  return ListView.builder(itemCount: _taskController.taskList.length, itemBuilder: (_, index){
    print(_taskController.taskList.length);
      return AnimationConfiguration.staggeredList(
        position: index, child: SlideAnimation(child: FadeInAnimation(child: Row(children: [
          GestureDetector(
            onTap: (){
             _shotBottomSheet(context, _taskController.taskList[index]);

            },
            child: TaskTile(_taskController.taskList[index]),
          )
        ],
        )
        ),
        )
);
    

  });
})

);

  }

_shotBottomSheet(BuildContext context, Task task){
Get.bottomSheet(
Container(
  padding: const EdgeInsets.only(top: 4),
  height: task.isCompleted == 1? 
  MediaQuery.of(context).size.height*0.24:
  MediaQuery.of(context).size.height*0.32,
  color:Get.isDarkMode? darkGreyClr:Colors.white,
  child: Column(
    children: [
      Container(
        height: 6,
        width: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Get.isDarkMode? Colors.grey[600]:Colors.grey[300],

        ),
      ),
      Spacer(),
      task.isCompleted == 1?
      Container():
      _bottomSheetButton(
        label: 'Tarea Completada',
        onTap: (){
          Get.back();
        },
        clr:primaryClr,
        context: context,
      ),
      SizedBox(height: 20,),

      _bottomSheetButton(
        label: 'Borrar Tarea',
        onTap: (){
          Get.back();
        },
        clr:Colors.red[300]!,
        context: context,
      ),
      SizedBox(height: 20,),
      _bottomSheetButton(
        label: 'Cerrar',
        onTap: (){
          Get.back();
        },
        clr:Colors.red[300]!,
        isClose: true,
        context: context,
      ),
       SizedBox(height: 10,),
    ]
  )
),
);

}

_bottomSheetButton({required label, required Function() onTap,  required clr, bool isClose=false, required BuildContext context})
{
return GestureDetector(
     onTap:onTap,
     child: Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      height: 55,
      width: MediaQuery.of(context).size.width*0.9,
      
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color:isClose==true?Get.isDarkMode?Colors.grey[600]:Colors.grey[300]:clr
        ),
        borderRadius: BorderRadius.circular(20),  
        color:isClose==true?Colors.teal:clr,
      ),

      child: Center(
        child: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
      )
     )
);



}
//calendario
  _addDateBar() {
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
