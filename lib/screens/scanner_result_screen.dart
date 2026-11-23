import 'package:flutter/material.dart';
import 'add_medication_step1.dart';
import 'add_medication_step2.dart';

class ScannerResultScreen extends StatelessWidget {
  const ScannerResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const String medNombre = 'Amoxicilina';
    const String medDosis = '500';
    const String medUnidad = 'mg';
    const String medFrecuencia = 'Cada 8 horas';
    const String medLaboratorio = 'Bayer S.A';
    const String medRegistro = 'MX-2024-0847';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Medicamento Encontrado', style: TextStyle(color: Colors.black, fontSize: 16)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, color: Colors.green, size: 50),
            ),
          ),
          const SizedBox(height: 30),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Información detectada', style: TextStyle(color: Colors.grey, fontSize: 14)),
                SizedBox(height: 20),
                _InfoRow(etiqueta: 'Medicamento', valor: medNombre),
                Divider(height: 30),
                _InfoRow(etiqueta: 'Dosis', valor: '$medDosis$medUnidad'),
                Divider(height: 30),
                _InfoRow(etiqueta: 'Frecuencia', valor: medFrecuencia),
                Divider(height: 30),
                _InfoRow(etiqueta: 'Laboratorio', valor: medLaboratorio),
                Divider(height: 30),
                _InfoRow(etiqueta: 'Registro', valor: medRegistro),
              ],
            ),
          ),
          const SizedBox(height: 40),

          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddMedicationStep2(
                    nombre: medNombre,
                    dosis: medDosis,
                    unidad: medUnidad,
                    frecuencia: medFrecuencia,
                    horaInicio: TimeOfDay.now(),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade200,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Continuar', style: TextStyle(color: Colors.white, fontSize: 16)),
          ),
          const SizedBox(height: 10),

          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AddMedicationStep1()),
              );
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.grey.shade100,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Editar Manualmente', style: TextStyle(color: Colors.grey, fontSize: 16)),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String etiqueta;
  final String valor;

  const _InfoRow({required this.etiqueta, required this.valor});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(etiqueta, style: const TextStyle(color: Colors.grey, fontSize: 16)),
        Text(valor, style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500)),
      ],
    );
  }
}