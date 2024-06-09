import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: ClinicScreen()));
}

class ClinicScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clínica Affidea'),
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.asset('../img/affidea1.png'),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Clínica Affidea\nQuinta da Milhã - Estrada do Salgueiro,\n6000-168 Castelo Branco\n272 348 860',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Divider(),
                  Text(
                    'Serviços',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Divider(),
                  serviceItem('Consulta Dr. Miguel', '90 Euros'),
                  Divider(),
                  serviceItem('Consulta Dr. Miguel', '90 Euros'),
                  Divider(),
                  serviceItem('Consulta Dr. Miguel', '90 Euros'),
                  Divider(),
                  serviceItem('Consulta Dr. Miguel', '90 Euros'),
                  Divider(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget serviceItem(String serviceName, String price) {
    return ListTile(
      title: Text(serviceName),
      subtitle: Text(price),
      trailing: ElevatedButton(
        onPressed: () {},
        child: Text(
          'Agendar',
          style: TextStyle(color: Colors.white),
          ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
        ),
      ),
    );
  }
}
