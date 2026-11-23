import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'add_medication_step2.dart';
import 'package:proyectofinal/screens/barcode_scanner_screen.dart';

class AddMedicationStep1 extends StatefulWidget {
  const AddMedicationStep1({super.key});

  @override
  State<AddMedicationStep1> createState() => _AddMedicationStep1State();
}

class _AddMedicationStep1State extends State<AddMedicationStep1> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _dosisController = TextEditingController();
  final TextEditingController _unidadController = TextEditingController();

  String _frecuenciaSeleccionada = 'Cada 8 Horas';
  TimeOfDay _horaInicio = const TimeOfDay(hour: 8, minute: 0);
  final DateTime _fechaInicio = DateTime.now();
  final DateTime _fechaFinal = DateTime.now().add(const Duration(days: 7));

  final List<String> _frecuencias = [
    'Cada 4 Horas',
    'Cada 6 Horas',
    'Cada 8 Horas',
    'Cada 12 Horas',
    'Una vez al día',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Paso 1 de 3',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            Text(
              'Agregar un medicamento',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),

          const Text(
            'NOMBRE DE MEDICAMENTO',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          TextField(
            controller: _nombreController,
            decoration: InputDecoration(
              hintText: 'Ej: Acetaminofen',
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 15),

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'DOSIS',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      controller: _dosisController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Ej: 500',
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'UNIDAD',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      controller: _unidadController,
                      decoration: InputDecoration(
                        hintText: 'Ej: mg',
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          const Text(
            'FRECUENCIA',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _frecuencias.map((frecuencia) {
              final isSelected = _frecuenciaSeleccionada == frecuencia;
              return GestureDetector(
                onTap: () =>
                    setState(() => _frecuenciaSeleccionada = frecuencia),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.blue.shade100
                        : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    frecuencia,
                    style: TextStyle(
                      color: isSelected ? Colors.blue.shade700 : Colors.black87,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 25),

          const Text(
            'HORA DE INICIO',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          GestureDetector(
            onTap: () async {
              final TimeOfDay? horaSeleccionada = await showTimePicker(
                context: context,
                initialTime: _horaInicio,
              );
              if (horaSeleccionada != null) {
                setState(() {
                  _horaInicio = horaSeleccionada;
                });
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_horaInicio.format(context)),
                  const Icon(Icons.access_time),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),

          ElevatedButton.icon(
            onPressed: () async {

              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BarcodeScannerScreen()),
              );

              if (result != null && result is String) {
                
                final Map<String, String> apiSimulada = {
                  '7701234567890': 'Dolex Forte 500mg',
                  '7709876543210': 'Ibuprofeno 400mg',
                  '123456789': 'Amoxicilina 250mg',
                };
                
                String nombreMedicamento = apiSimulada[result] ?? 'Cod: $result';

                setState(() {
                  _nombreController.text = nombreMedicamento;
                });

                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('¡Código escaneado con éxito!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              }
            },
            icon: const Icon(Icons.qr_code_scanner, color: Colors.blue),
            label: const Text(
              'Escanea código de barras',
              style: TextStyle(color: Colors.blue),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade50,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              if (_nombreController.text.isEmpty ||
                  _dosisController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Por favor, ingresa el nombre y la dosis'),
                  ),
                );
                return;
              }

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddMedicationStep2(
                    nombre: _nombreController.text,
                    dosis: _dosisController.text,
                    unidad: _unidadController.text.isEmpty
                        ? 'mg'
                        : _unidadController.text,
                    frecuencia: _frecuenciaSeleccionada,
                    horaInicio: _horaInicio,
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade200,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'CONTINUAR',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10),
                Icon(Icons.arrow_forward, color: Colors.white),
              ],
            ),
          ),
        ],
      ),
    );
  }
}