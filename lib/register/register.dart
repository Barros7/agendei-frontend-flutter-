import 'package:agendei/login/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> registerUser() async {
    final String name = _nameController.text;
    final String email = _emailController.text;
    final String phone = _phoneController.text;
    final String password = _passwordController.text;

    final response = await http.post(
      Uri.parse('http://localhost:8083/users'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Sucesso
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen()));
    } else {
      // Erro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao registrar usuário')),
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

              // Campo de Nome
              SizedBox(
                width: 370, // Largura específica para o campo de email
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Digite o seu nome',
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

              // Campo de Email
              SizedBox(
                width: 370, // Largura específica para o campo de senha
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
              SizedBox(height: 20), // Espaço entre o campo de senha e o botão acessar

              // Campo de Telefone
              SizedBox(
                width: 370, // Largura específica para o campo de senha
                child: TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    hintText: 'Digite o seu telefone',
                    filled: true,
                    fillColor: Color.fromARGB(255, 230, 230, 230),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20), // Espaço entre o campo de senha e o botão acessar

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

              // Botão Registrar
              SizedBox(
                width: 370, // Largura específica para o botão
                child: ElevatedButton(
                  onPressed: registerUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 102, 252, 241), // Cor do botão
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 20.0), // Altura do botão
                  ),
                  child: Text('Registrar'),
                ),
              ),
              SizedBox(height: 90), // Espaço entre o botão acessar e o botão registrar

              // Botão Acessar
              SizedBox(
                width: 370, // Largura específica para o botão
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 102, 252, 241), // Cor do botão
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                  ),
                  child: Text('Acessar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
