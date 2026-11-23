import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/medicamento_provider.dart';
import '../models/medicamento.dart';

class MedicationListScreen extends StatefulWidget {
  const MedicationListScreen({super.key});

  @override
  State<MedicationListScreen> createState() => _MedicationListScreenState();
}

class _MedicationListScreenState extends State<MedicationListScreen> {
  String _filtroSeleccionado = 'Todos';

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<MedicamentoProvider>(context);

    List<Medicamento> listaFiltrada = prov.medicamentos;
    if (_filtroSeleccionado != 'Todos') {
      listaFiltrada = prov.medicamentos.where((m) => m.estado == _filtroSeleccionado).toList();
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'MEDICAMENTOS',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Gestión de tus tratamientos activos',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 20),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ['Todos', 'Pendiente', 'Tomada', 'Atrasada'].map((filtro) {
                  final esSeleccionado = _filtroSeleccionado == filtro;
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ChoiceChip(
                      label: Text(filtro),
                      selected: esSeleccionado,
                      selectedColor: Colors.blue.shade200,
                      labelStyle: TextStyle(
                        color: esSeleccionado ? Colors.white : Colors.black87,
                        fontWeight: esSeleccionado ? FontWeight.bold : FontWeight.normal,
                      ),
                      onSelected: (bool selected) {
                        if (selected) {
                          setState(() => _filtroSeleccionado = filtro);
                        }
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: listaFiltrada.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.medication_outlined, size: 60, color: Colors.grey.shade400),
                          const SizedBox(height: 10),
                          Text(
                            'No hay medicamentos en "${_filtroSeleccionado}"',
                            style: const TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: listaFiltrada.length,
                      itemBuilder: (context, index) {
                        final med = listaFiltrada[index];
                        return _buildMedCard(context, med, prov);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMedCard(BuildContext context, Medicamento med, MedicamentoProvider prov) {
    Color colorEstado = Colors.blue;
    if (med.estado == 'Tomada') colorEstado = Colors.green;
    if (med.estado == 'Atrasada') colorEstado = Colors.redAccent;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: colorEstado.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.medication, color: colorEstado, size: 30),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  med.nombre,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  '${med.dosis} • ${med.frecuencia}',
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
                const SizedBox(height: 5),
                Text(
                  'Próxima: ${DateFormat('h:mm a').format(med.proximaDosis)}',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'tomar') {
                prov.cambiarEstado(med.id, 'Tomada');
              } else if (value == 'eliminar') {
                prov.eliminarMedicamento(med.id);
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: 'tomar',
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green, size: 20),
                    SizedBox(width: 10),
                    Text('Marcar Tomada'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'eliminar',
                child: Row(
                  children: [
                    Icon(Icons.delete, color: Colors.red, size: 20),
                    SizedBox(width: 10),
                    Text('Eliminar'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}