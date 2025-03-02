// Archivo: lib/modules/auth/login_screen.dart

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.post(
      Uri.parse('http://localhost:5000/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'usuario': _emailController.text,
        'contraseña': _passwordController.text,
      }),
    );

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success']) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', data['token']);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Inicio de sesión exitoso')),
        );

        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'])),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error de conexión con el servidor')),
      );
    }
  }

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('token');
  }

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    if (await isLoggedIn()) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _login,
                    child: const Text('Iniciar Sesión'),
                  ),
          ],
        ),
      ),
    );
  }
}