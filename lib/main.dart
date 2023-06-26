import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:m_trackn/screens/beforelogin/splash_screen.dart';
// import 'package:m_trackn/login.dart';
// import 'package:m_trackn/screens/login/switch_screen.dart';
// import 'package:m_trackn/screens/home/screen_home.dart';
// ignore: library_prefixes, depend_on_referenced_packages
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'firebase_options.dart';

// ignore: non_constant_identifier_names
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  //initialize hive
  await Hive.initFlutter();
  // ignore: unused_local_variable
  var box = await Hive.openBox('mybox');
  await Hive.initFlutter();

  WidgetsFlutterBinding.ensureInitialized();
  final dir = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(dir.path);

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
