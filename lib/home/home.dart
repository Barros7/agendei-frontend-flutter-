import 'package:agendei/explore/explore_car_wash.dart';
import 'package:agendei/explore/explore_medical_appointment.dart';
import 'package:agendei/profile/profile.dart';
import 'package:agendei/reservation/reservetion.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> services = [
    {"name": "Médico", "icon": "../img/medico.png", "screen": ExploreMedicalAppointmentScreen()},
    {"name": "Dentista", "icon": "../img/dentista.png", "screen": null},
    {"name": "Cabeleireiro", "icon": "../img/cabelereiro.png", "screen": null},
    {"name": "Personal", "icon": "../img/ginasio.png", "screen": null},
    {"name": "Veterinário", "icon": "../img/veterinario.png", "screen": null},
    {"name": "Pilates", "icon": "../img/yoga.png", "screen": null},
    {"name": "Manicure", "icon": "../img/manicure.png", "screen": null},
    {"name": "Nutricionista", "icon": "../img/nutricionista.png", "screen": null},
    {"name": "Lava-Rápido", "icon": "../img/oficina.png", "screen": ExploreCarWashScreen()},
  ];

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
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey, width: 1)),
            ),
            child: Image.asset('../img/logo2.png', height: 40),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Agende os seus serviços',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: Colors.grey,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Qual cidade você está?',
                suffixIcon: Icon(Icons.location_on),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 50.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1,
              ),
              itemCount: services.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (services[index]["screen"] != null) {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => services[index]["screen"],
                      ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Página não implementada ainda.')),
                      );
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.asset(services[index]["icon"]!, fit: BoxFit.contain),
                      ),
                      Text(services[index]["name"]!),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
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
