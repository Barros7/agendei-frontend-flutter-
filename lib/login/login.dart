import 'package:agendei/register/register.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Digite o seu email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Digite a sua senha'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Acessar'),
              onPressed: () {
                _login(emailController.text, passwordController.text, context);
              },
            ),
            TextButton(
              child: Text('Registrar'),
              onPressed: () {
                // Adicione a lógica de navegação para a tela de registro
              },
            )
          ],
        ),
      ),
    );
  }

  void _login(String email, String password, BuildContext context) async {
    var url = 'http://localhost:8080/login';
    var response = await http.post(Uri.parse(url), body: {
      'email': email,
      'password': password,
    });
    if (response.statusCode == 200) {
      //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => RegisterUser()));
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Erro de Login'),
          content: Text('Email ou senha incorretos!'),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          ],
        ),
      );
    }
  }
}
