import 'package:agendei/home/home.dart';
import 'package:agendei/register/register.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:localstorage/localstorage.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> loginUser() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    final response = await http.post(
      Uri.parse('http://localhost:8083/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // Sucesso
      final userId = response.body;
      await initLocalStorage();
      localStorage.setItem('userId', userId);
      //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => RoutePage()));
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()));
    } else {
      // Erro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao fazer login')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 20.0, left: 60.0, right: 60.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Logo
              Image.asset('../img/logo2.png', height: 50),
              SizedBox(height: 80), // Espaço entre o logo e o campo de email

              // Campo de Email
              SizedBox(
                width: 370, // Largura específica para o campo de email
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Digite o seu email',
                    filled: true,
                    fillColor: Color.fromARGB(255, 230, 230, 230),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20), // Espaço entre o campo de email e o campo de senha

              // Campo de Senha
              SizedBox(
                width: 370, // Largura específica para o campo de senha
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Digite a sua senha',
                    filled: true,
                    fillColor: Color.fromARGB(255, 230, 230, 230),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30), // Espaço entre o campo de senha e o botão acessar

              // Botão Acessar
              SizedBox(
                width: 370, // Largura específica para o botão
                child: ElevatedButton(
                  onPressed: loginUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 102, 252, 241), // Cor do botão
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 20.0), // Altura do botão
                  ),
                  child: Text('Acessar'),
                ),
              ),
              SizedBox(height: 90), // Espaço entre o botão acessar e o botão registrar

              // Botão Registrar
              SizedBox(
                width: 370, // Largura específica para o botão
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => RegisterScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 102, 252, 241), // Cor do botão
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                  ),
                  child: Text('Registrar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LoginScreen(),
  ));
}
