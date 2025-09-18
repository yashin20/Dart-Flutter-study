import 'package:flutter/material.dart';
import 'package:toonflix/screens/home_screen.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //전체 위젯에 사용할 기본 데이터
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          surface: Color(0xFFE7626C),
        ),
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            color: Color(0xFF232B55),
          ),
        ),
        cardColor: Color(0xFFF4EDDB),
      ),
      home: HomeScreen(),
    );
  }
}
