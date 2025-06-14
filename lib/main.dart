import 'package:flutter/material.dart';
import 'package:number_funfact_flutter/src/home_menu.dart';
import 'package:number_funfact_flutter/src/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Numbers Funfact',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 58, 133, 183),
        ),
      ),
      home: const HomeMenuPage(title: 'Menu'),
      routes: routes,
    );
  }
}
