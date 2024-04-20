import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:notification_app/db/db_helper.dart';
import 'package:notification_app/ui/home_page.dart';
import 'package:notification_app/ui/services/theme_services.dart';
import 'package:notification_app/ui/theme.dart';

Future<void> main() async {
  // Configuración regional predeterminada
  /*
  final languageCode = ui.window.locale.languageCode;
  final countryCode = ui.window.locale.countryCode;

  String defaultLocale = languageCode ?? '';
  if (countryCode != null) {
    defaultLocale += '_$countryCode';
  }

  Intl.defaultLocale = defaultLocale;
  */

  // Inicialización de GetStorage
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDB() ;
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,       
      ],
      locale: const Locale('es'),
      supportedLocales: const [
        Locale('es'),
      ],
      theme: Themes.light,
      darkTheme: Themes.dark,
      //themeMode: ThemeMode.light,
      themeMode: ThemeService().theme,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

      home: const HomePage(),
    );
  }
}
