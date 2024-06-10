import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: ReservationScreen()));
}

class ReservationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minhas Reservas'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: 2,  // Simulating two reservations
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Consulta Dr. Rui Costa', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Text('Clínica Affidea'),
                  SizedBox(height: 5),
                  Text('Quinta da Milhã - Estrada do Salgueiro, 6000-168'),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, color: Colors.green),
                      SizedBox(width: 5),
                      Text('28/06/2024'),
                      SizedBox(width: 20),
                      Icon(Icons.access_time, color: Colors.green),
                      SizedBox(width: 5),
                      Text('9:30'),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.attach_money, color: Colors.green),
                      Text('90,00'),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Reagendar'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Excluir Reserva'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
