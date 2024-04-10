import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:intl/intl.dart';
import 'package:notification_app/ui/services/notification_services.dart';
import 'package:notification_app/ui/services/theme_services.dart';
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
      body: Column(
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat.yMMMMd().format(DateTime.now()),
                      //style:subHeadingStyle ,
                    ),
                    const Text("Today")
                  ],
                ),
              )
            ],
          )
          /*
          Text(
            "Theme Data",
            style: TextStyle(fontSize: 30),
          )
          */
        ],
      ),
    );
  }

  _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.colorScheme.background,
      leading: GestureDetector(
        onTap: () {
          //print("hola mundo");
          ThemeService().switchTheme();
          notifyHelper.displayNotification(
            title: "Hola Mundo",
            body: Get.isDarkMode
                ? "Activado modo oscuro"
                : "Activado modo blanco",
          );
        },
        child: Icon(
          Get.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round,
          size: 20,
          //color: Get.isDarkMode ? Colors.white:Colors.black
        ),
      ),
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage("assets/images/profile.jpg"),
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }
}
