import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/medicamento_provider.dart';
import '../models/medicamento.dart';
import '../services/notification_service.dart';
import 'success_screen.dart';

class AddMedicationStep3 extends StatefulWidget {
  final String nombre;
  final String dosis;
  final String unidad;
  final String frecuencia;
  final TimeOfDay horaInicio;
  final int cantidadDosis;

  const AddMedicationStep3({
    super.key,
    required this.nombre,
    required this.dosis,
    required this.unidad,
    required this.frecuencia,
    required this.horaInicio,
    required this.cantidadDosis,
  });

  @override
  State<AddMedicationStep3> createState() => _AddMedicationStep3State();
}

class _AddMedicationStep3State extends State<AddMedicationStep3> {
  final DateTime _fechaInicio = DateTime.now();
  final DateTime _fechaFin = DateTime.now().add(const Duration(days: 7));
  bool _notificacionesActivas = true;

  int _obtenerHorasIntervalo(String frecuencia) {
    final match = RegExp(r'(\d+)').firstMatch(frecuencia);
    if (match != null) {
      return int.parse(match.group(1)!);
    }
    return 24;
  }

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
            Text('Paso 3 de 3', style: TextStyle(color: Colors.grey, fontSize: 12)),
            Text('Duración del medicamento', style: TextStyle(color: Colors.black, fontSize: 16)),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          Row(
            children: [
              Expanded(child: Container(height: 5, decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)))),
              const SizedBox(width: 10),
              Expanded(child: Container(height: 5, decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)))),
              const SizedBox(width: 10),
              Expanded(child: Container(height: 5, decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)))),
            ],
          ),
          const SizedBox(height: 25),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('PERÍODO DE MEDICAMENTO', style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold)),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('INICIO', style: TextStyle(color: Colors.grey, fontSize: 10)),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Icon(Icons.calendar_today, size: 16),
                                const SizedBox(width: 5),
                                Text(DateFormat('dd/MM/yyyy').format(_fechaInicio), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('FIN', style: TextStyle(color: Colors.grey, fontSize: 10)),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Icon(Icons.calendar_today, size: 16),
                                const SizedBox(width: 5),
                                Text(DateFormat('dd/MM/yyyy').format(_fechaFin), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Colors.blueAccent, Colors.lightBlueAccent]),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('RESUMEN DEL MEDICAMENTO', style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold)),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                      child: const Icon(Icons.medication, size: 40, color: Colors.blue),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('MEDICAMENTO', style: TextStyle(color: Colors.white70, fontSize: 10)),
                          Text(widget.nombre.toUpperCase(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                          Text('${widget.cantidadDosis} Dosis - ${widget.frecuencia}', style: const TextStyle(color: Colors.white, fontSize: 14)),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('RECORDATORIOS', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        Text('Recibe notificaciones de tus dosis', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                    Switch(
                      value: _notificacionesActivas,
                      activeColor: Colors.blue,
                      onChanged: (value) => setState(() => _notificacionesActivas = value),
                    )
                  ],
                ),
                if (_notificacionesActivas) ...[
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Icon(Icons.notifications_active, color: Colors.green.shade400, size: 20),
                        const SizedBox(width: 10),
                        Text('Las notificaciones están activas', style: TextStyle(color: Colors.green.shade700, fontSize: 12)),
                      ],
                    ),
                  )
                ]
              ],
            ),
          ),
          const SizedBox(height: 30),

          ElevatedButton(
            onPressed: () async {
              final now = DateTime.now();
              final primeraDosis = DateTime(
                _fechaInicio.year,
                _fechaInicio.month,
                _fechaInicio.day,
                widget.horaInicio.hour,
                widget.horaInicio.minute,
              );

              final int intervaloHoras = _obtenerHorasIntervalo(widget.frecuencia);
              final int totalDosis = widget.cantidadDosis > 0 ? widget.cantidadDosis : 1;
              final int baseId = DateTime.now().millisecondsSinceEpoch;
              final List<Medicamento> listaDosis = [];

              for (int i = 0; i < totalDosis; i++) {
                final fechaDosis = primeraDosis.add(Duration(hours: intervaloHoras * i));
                final String dosisId = '${baseId}_$i';

                final med = Medicamento(
                  id: dosisId,
                  nombre: widget.nombre,
                  dosis: '${widget.dosis} ${widget.unidad}',
                  frecuencia: widget.frecuencia,
                  proximaDosis: fechaDosis,
                );

                listaDosis.add(med);

                if (_notificacionesActivas && fechaDosis.isAfter(now)) {
                  await NotificationService().scheduleMedicationNotification(
                    id: (baseId + i) % 2147483647,
                    title: '¡Hora de tu medicamento! 💊',
                    body: 'Es momento de tomar ${widget.nombre} (${widget.dosis} ${widget.unidad})',
                    scheduledDate: fechaDosis,
                  );
                }
              }

              await Provider.of<MedicamentoProvider>(context, listen: false)
                  .agregarListaMedicamentos(listaDosis);

              if (mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const SuccessScreen()),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade200,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Guardar medicamento', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
          ),
        ],
      ),
    );
  }
}