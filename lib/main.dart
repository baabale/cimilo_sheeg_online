import 'package:flutter/material.dart';
import 'screens/home.dart';

void main() => runApp(CimiloSheegApp());

class CimiloSheegApp extends StatelessWidget {
  const CimiloSheegApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      home: HomeScreen(),
    );
  }
}
