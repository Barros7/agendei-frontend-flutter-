import 'package:agendei/explore/explore_car_wash.dart';
import 'package:agendei/home/home.dart';
import 'package:agendei/reservation/reservetion.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:localstorage/localstorage.dart';

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

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 3;
  late Map<String, dynamic> _userData;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  void _fetchUserData() async {
    final userId = localStorage.getItem('userId');

    if (userId != null) {
      final response = await http.get(Uri.parse('http://localhost:8083/users/$userId'));

      if (response.statusCode == 200) {
        setState(() {
          _userData = json.decode(response.body);
        });
      } else {
        // Trate o erro aqui
        print('Failed to load user data');
      }
    } else {
      // Trate o caso em que o userId não está armazenado
      print('User ID not found in shared preferences');
    }
  }

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
        title: Text('Meu Perfil'),
        backgroundColor: Colors.teal,
      ),
      body: _userData == null
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: <Widget>[
                ListTile(
                  title: Text('Nome'),
                  subtitle: Text(_userData['name']),
                ),
                Divider(),
                ListTile(
                  title: Text('Email'),
                  subtitle: Text(_userData['email']),
                ),
                Divider(),
                ListTile(
                  title: Text('Telefone'),
                  subtitle: Text(_userData['phone']),
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
