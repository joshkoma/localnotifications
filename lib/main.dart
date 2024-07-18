import 'package:flutter/material.dart';
import 'package:localnotifications/screens.dart/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //initialize all apps
  await HomePage.init(); //initialize inside main function

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}
