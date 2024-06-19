import 'package:agendei/explore/explore_car_wash.dart';
import 'package:agendei/home/home.dart';
import 'package:agendei/profile/profile.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: ReservationScreen()));
}

class ReservationScreen extends StatefulWidget {
  @override
  _ReservationScreenState createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
         Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else if (index == 1) {
         Navigator.push(context, MaterialPageRoute(builder: (context) => ExploreCarWashScreen()));
      } else if (index == 2) {
         Navigator.push(context, MaterialPageRoute(builder: (context) => ReservationScreen()));
      } else {
         Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
      }
    });
  }

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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        onTap: _onItemTapped,
      ),
    );
  }
}
