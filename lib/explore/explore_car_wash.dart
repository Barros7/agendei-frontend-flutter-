import 'package:agendei/booking/booking_car_wash_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ExploreCarWashScreen extends StatefulWidget {
  @override
  _ExploreCarWashScreenState createState() => _ExploreCarWashScreenState();
}

class _ExploreCarWashScreenState extends State<ExploreCarWashScreen> {
  Future<List<Map<String, dynamic>>> fetchClinics() async {
    final response = await http.get(Uri.parse('http://localhost:8081/car-wash'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Map<String, dynamic>> clinics = data.map((clinic) {
        return {
          'carWashId': clinic['carWashId'],
          'name': clinic['name'],
          'address': clinic['address'],
          'postalCode': clinic['postalCode'],
          'phoneNumber': clinic['phoneNumber'],
          'serviceManager': clinic['serviceManager'],
          'speciality': clinic['speciality'],
          'price': clinic['price'],
        };
      }).toList();
      return clinics;
    } else {
      throw Exception('Failed to load clinics');
    }
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookingCarWashScreen(),
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
                              Text('serviceManager: ${clinics[index]['serviceManager']}', style: TextStyle(fontSize: 14)),
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
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ExploreCarWashScreen(),
  ));
}
