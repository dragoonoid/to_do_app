import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/Screens/home_screen.dart';
import 'package:to_do_app/services/theme_services.dart';
import 'package:get_storage/get_storage.dart';
import 'Screens/theme.dart';

Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: Themes.light,
      themeMode: ThemeServices().theme,
      darkTheme: Themes.dark,
      home: const HomeScreen(),
    );
  }
}

