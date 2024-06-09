import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(MaterialApp(home: BookingScreen()));
}

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fazer uma reserva'),
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Defina a ação para o botão de retorno
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay; // atualiza o dia focado
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TimeChip(label: "9:00", selected: false),
                TimeChip(label: "9:30", selected: true),
                TimeChip(label: "10:00", selected: false),
                TimeChip(label: "10:30", selected: false),
              ],
            ),
          ),
          Divider(),
          ListTile(
            title: Text('Consulta Dr. Miguel'),
            subtitle: Text('90 Euros'),
          ),
          Divider(),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: Text('Confirmar reserva'),
                onPressed: () {
                  // Ação de confirmação
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TimeChip extends StatelessWidget {
  final String label;
  final bool selected;

  // Modificador 'required' adicionado
  TimeChip({required this.label, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: (bool value) {
        // Defina a ação ao selecionar
      },
      backgroundColor: Colors.grey[200],
      selectedColor: Colors.teal,
    );
  }
}
