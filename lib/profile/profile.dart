import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meu Perfil'),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Nome'),
            subtitle: Text('John Doe'),
          ),
          Divider(),
          ListTile(
            title: Text('Email'),
            subtitle: Text('jdoe@est.pt'),
          ),
          Divider(),
          ListTile(
            title: Text('Telefone'),
            subtitle: Text('+351 123 456'),
          ),
        ],
      ),
    );
  }
}
