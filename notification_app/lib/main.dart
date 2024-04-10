import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:notification_app/ui/home_page.dart';
import 'package:notification_app/ui/services/theme_services.dart';
import 'package:notification_app/ui/theme.dart';

Future<void> main() async {
WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: Themes.light,
      darkTheme: Themes.dark,
      //themeMode: ThemeMode.light,
      themeMode: ThemeService().theme,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      
      home:  const HomePage(),
    );
  }
}
