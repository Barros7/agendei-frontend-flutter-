import 'package:agendei/booking/booking_medical_appointment_screen.dart';
import 'package:agendei/home/home.dart';
import 'package:agendei/profile/profile.dart';
import 'package:agendei/reservation/reservetion.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:localstorage/localstorage.dart';

class ExploreMedicalAppointmentScreen extends StatefulWidget {
  @override
  _ExploreMedicalAppointmentScreenState createState() => _ExploreMedicalAppointmentScreenState();
}

class _ExploreMedicalAppointmentScreenState extends State<ExploreMedicalAppointmentScreen> {
  int _selectedIndex = 1;

  Future<List<Map<String, dynamic>>> fetchClinics() async {
    final response = await http.get(Uri.parse('http://localhost:8082/clinics'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Map<String, dynamic>> clinics = data.map((clinic) {
        return {
          'clinicId': clinic['clinicId'],
          'name': clinic['name'],
          'address': clinic['address'],
          'postalCode': clinic['postalCode'],
          'phoneNumber': clinic['phoneNumber'],
          'doctor': clinic['doctor'],
          'speciality': clinic['speciality'],
          'price': clinic['price'],
        };
      }).toList();
      return clinics;
    } else {
      throw Exception('Failed to load clinics');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
         Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else if (index == 1) {
         Navigator.push(context, MaterialPageRoute(builder: (context) => ExploreMedicalAppointmentScreen()));
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
          SizedBox(height: 20),
          Text('Explorar', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal)),
          Text('Lavagem de Carro', style: TextStyle(fontSize: 18, color: Colors.grey)),
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
                  List<Map<String, dynamic>> clinics = snapshot.data!;
                  return ListView.builder(
                    itemCount: clinics.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          initLocalStorage();
                          String selectedClinicId = clinics[index]['clinicId'];
                          localStorage.setItem("serviceId", selectedClinicId);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookingMedicalAppointmentScreen(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(clinics[index]['name'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              SizedBox(height: 4),
                              Text(clinics[index]['address'], style: TextStyle(fontSize: 14)),
                              Text(clinics[index]['postalCode'], style: TextStyle(fontSize: 14)),
                              Text(clinics[index]['phoneNumber'], style: TextStyle(fontSize: 14)),
                              Text('doctor: ${clinics[index]['doctor']}', style: TextStyle(fontSize: 14)),
                              Text('Speciality: ${clinics[index]['speciality']}', style: TextStyle(fontSize: 14)),
                              Text('Price: ${clinics[index]['price']}', style: TextStyle(fontSize: 14)),
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
    home: ExploreMedicalAppointmentScreen(),
  ));
}
