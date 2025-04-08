import 'package:flutter/material.dart';
import 'package:tic_tac_toe/ui/login_screen.dart';
import 'package:tic_tac_toe/ui/game_screen.dart';
import 'package:tic_tac_toe/ui/results_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/game': (context) => const GameScreen(),
        '/results': (context) => const ResultsScreen(),
      },
    );
  }
}
