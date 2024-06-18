import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExploreScreen extends StatelessWidget {
  final List<Map<String, String>> clinics = [
    {
      'name': 'Clínica Affidea',
      'address': 'Quinta da Milhã - Estrada do Salgueiro, 6000-168',
      'city': 'Castelo Branco',
      'phone': '272 348 860',
    },
    {
      'name': 'Clínica Affidea',
      'address': 'Quinta da Milhã - Estrada do Salgueiro, 6000-168',
      'city': 'Castelo Branco',
      'phone': '272 348 860',
    },
    {
      'name': 'Clínica Affidea',
      'address': 'Quinta da Milhã - Estrada do Salgueiro, 6000-168',
      'city': 'Castelo Branco',
      'phone': '272 348 860',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20),
          Text('Explorar', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal)),
          Text('Médico', style: TextStyle(fontSize: 18, color: Colors.grey)),
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
            child: ListView.builder(
              itemCount: clinics.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(clinics[index]['name']!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(height: 4),
                      Text(clinics[index]['address']!, style: TextStyle(fontSize: 14)),
                      Text('${clinics[index]['city']}', style: TextStyle(fontSize: 14)),
                      Text(clinics[index]['phone']!, style: TextStyle(fontSize: 14)),
                      Divider(thickness: 1, color: Colors.grey),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      )
    );
  }
}
