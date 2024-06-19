import 'package:agendei/reservation/reservetion.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BookingMedicalAppointmentScreen extends StatefulWidget {

  @override
  _BookingMedicalAppointmentScreenState createState() => _BookingMedicalAppointmentScreenState();
}

class _BookingMedicalAppointmentScreenState extends State<BookingMedicalAppointmentScreen> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  TimeOfDay? _selectedTime;

  Future<void> _confirmBooking() async {
    final userId = localStorage.getItem('userId');
    final clinicId = localStorage.getItem('serviceId');

    final String medicalAppointmentState = "Agendado";
    final String dateMedicalAppointment = _selectedDay.toIso8601String().split('T')[0];
    final String hourMedicalAppointment = _selectedTime != null ? _selectedTime!.format(context) : '';

    final response = await http.post(
      Uri.parse('http://localhost:8082/medical-appointments'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
          "patientId": userId,
          "clinicId": clinicId,
          "dateMedicalAppointment": dateMedicalAppointment,
          "hourMedicalAppointment": hourMedicalAppointment,
          "medicalAppointmentState": medicalAppointmentState
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Reserva confirmada!')),
      );

      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => ReservationScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Falha ao confirmar a reserva.')),
      );
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fazer uma reserva'),
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
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
          ListTile(
            title: Text('Hora da reserva: ${_selectedTime?.format(context) ?? 'Selecionar hora'}'),
            trailing: Icon(Icons.access_time),
            onTap: () => _selectTime(context),
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
                onPressed: _confirmBooking,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
