import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/medicamento_provider.dart';
import '../models/medicamento.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<MedicamentoProvider>(context);

    final medicamentosDelDia = prov.medicamentos.where((med) {
      if (_selectedDay == null) return false;
      return med.proximaDosis.year == _selectedDay!.year &&
             med.proximaDosis.month == _selectedDay!.month &&
             med.proximaDosis.day == _selectedDay!.day;
    }).toList();

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('CALENDARIO', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  Text(
                    DateFormat('MMMM yyyy', 'es_ES').format(_focusedDay).toUpperCase(),
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              calendarStyle: CalendarStyle(
                selectedDecoration: const BoxDecoration(color: Colors.black87, shape: BoxShape.rectangle, borderRadius: BorderRadius.all(Radius.circular(10))),
                todayDecoration: BoxDecoration(color: Colors.blue.shade200, shape: BoxShape.rectangle, borderRadius: const BorderRadius.all(Radius.circular(10))),
                defaultDecoration: const BoxDecoration(shape: BoxShape.rectangle),
                weekendDecoration: const BoxDecoration(shape: BoxShape.rectangle),
              ),
            ),
          ),
          const SizedBox(height: 20),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${prov.cantidadTomados} de ${prov.cantidadTotal} dosis tomadas', style: TextStyle(color: Colors.blue.shade800)),
                Text('Día ${_selectedDay?.day}', style: TextStyle(color: Colors.blue.shade800, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: medicamentosDelDia.isEmpty
                ? const Center(child: Text("No hay medicamentos para este día"))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: medicamentosDelDia.length,
                    itemBuilder: (context, index) {
                      final med = medicamentosDelDia[index];
                      return _buildDailyMedicationCard(med);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyMedicationCard(Medicamento med) {
    Color cardColor = Colors.grey.shade100;
    Color iconColor = Colors.grey;
    IconData statusIcon = Icons.radio_button_unchecked;

    if (med.estado == 'Tomada') {
      cardColor = Colors.green.shade50;
      iconColor = Colors.green;
      statusIcon = Icons.check_circle;
    } else if (med.estado == 'Atrasada') {
      cardColor = Colors.red.shade50;
      iconColor = Colors.redAccent;
      statusIcon = Icons.cancel;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.blue.shade100, borderRadius: BorderRadius.circular(10)),
            child: Text(DateFormat('h:mm\na').format(med.proximaDosis), textAlign: TextAlign.center, style: TextStyle(color: Colors.blue.shade700, fontSize: 12, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 15),
          const Icon(Icons.medication, size: 30, color: Colors.blue),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(med.nombre, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(med.dosis, style: const TextStyle(color: Colors.grey, fontSize: 14)),
              ],
            ),
          ),
          Icon(statusIcon, color: iconColor, size: 30),
        ],
      ),
    );
  }
}