import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'screens/home_screen.dart';
import 'theme/theme.dart';
import 'model/pormodoro_provider.dart';

void main() {
  var widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => PomodoroProvider(),
          )
        ],
        child: const PomodoroApp(),
      ),
    );
  });
}

class PomodoroApp extends StatefulWidget {
  const PomodoroApp({Key? key}) : super(key: key);

  @override
  State<PomodoroApp> createState() => _PomodoroAppState();
}

class _PomodoroAppState extends State<PomodoroApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final pomodoroTheme = PomodoroTheme.dark();

    return MaterialApp(
      title: 'Pomodoro Timer',
      theme: pomodoroTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
      },
    );
  }
}
