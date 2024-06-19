import 'package:agendei/booking/booking_car_wash_screen.dart';
import 'package:agendei/home/home.dart';
import 'package:agendei/profile/profile.dart';
import 'package:agendei/reservation/reservetion.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:localstorage/localstorage.dart';

class ExploreCarWashScreen extends StatefulWidget {
  @override
  _ExploreCarWashScreenState createState() => _ExploreCarWashScreenState();
}

class _ExploreCarWashScreenState extends State<ExploreCarWashScreen> {
  int _selectedIndex = 0;

  Future<List<Map<String, dynamic>>> fetchClinics() async {
    final response =
        await http.get(Uri.parse('http://localhost:8081/car-wash'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Map<String, dynamic>> carWashes = data.map((carWash) {
        return {
          'carWashId': carWash['carWashId'],
          'name': carWash['name'],
          'address': carWash['address'],
          'postalCode': carWash['postalCode'],
          'phoneNumber': carWash['phoneNumber'],
          'serviceManager': carWash['serviceManager'],
          'speciality': carWash['speciality'],
          'price': carWash['price'],
        };
      }).toList();
      return carWashes;
    } else {
      throw Exception('Failed to load clinics');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else if (index == 1) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ExploreCarWashScreen()));
      } else if (index == 2) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ReservationScreen()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProfileScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20),
          Text('Explorar',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal)),
          Text('Lavagem de Carro',
              style: TextStyle(fontSize: 18, color: Colors.grey)),
          Divider(thickness: 1, color: Colors.grey),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Pesquisar',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          Divider(thickness: 1, color: Colors.grey),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: fetchClinics(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No clinics found'));
                } else {
                  List<Map<String, dynamic>> carWashes = snapshot.data!;
                  return ListView.builder(
                    itemCount: carWashes.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          initLocalStorage();
                          String selectedCarWashId = carWashes[index]['carWashId'];
                          localStorage.setItem("serviceId", selectedCarWashId);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookingCarWashScreen(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(carWashes[index]['name'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              SizedBox(height: 4),
                              Text(carWashes[index]['address'],
                                  style: TextStyle(fontSize: 14)),
                              Text(carWashes[index]['postalCode'],
                                  style: TextStyle(fontSize: 14)),
                              Text(carWashes[index]['phoneNumber'],
                                  style: TextStyle(fontSize: 14)),
                              Text(
                                  'serviceManager: ${carWashes[index]['serviceManager']}',
                                  style: TextStyle(fontSize: 14)),
                              Text(
                                  'Speciality: ${carWashes[index]['speciality']}',
                                  style: TextStyle(fontSize: 14)),
                              Text('Price: ${carWashes[index]['price']}',
                                  style: TextStyle(fontSize: 14)),
                              Divider(thickness: 1, color: Colors.grey),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
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

void main() {
  runApp(MaterialApp(
    home: ExploreCarWashScreen(),
  ));
}
