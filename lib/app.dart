// Archivo: lib/app.dart

import 'package:flutter/material.dart';
import 'package:proy_aqa/modules/auth/login_screen.dart';
import 'package:proy_aqa/modules/home/home_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AQa',
      theme: ThemeData.light(),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
