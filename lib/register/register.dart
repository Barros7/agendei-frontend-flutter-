import 'package:agendei/login/login.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
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
                  obscureText: true,
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
                  obscureText: true,
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
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 102, 252, 241), // Cor do botão
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 20.0), // Altura do botão
                  ),
                  child: Text('Registar'),
                ),
              ),
              SizedBox(height: 90), // Espaço entre o botão acessar e o botão registrar

              // Botão Registrar
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
