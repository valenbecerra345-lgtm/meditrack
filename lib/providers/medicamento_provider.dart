import 'package:flutter/material.dart';
import '../models/medicamento.dart';
import '../services/db_helper.dart';

class MedicamentoProvider extends ChangeNotifier {
  List<Medicamento> _medicamentos = [];

  List<Medicamento> get medicamentos => _medicamentos;

  List<Medicamento> get medicamentosHoy {
    final hoy = DateTime.now();
    return _medicamentos.where((m) =>
      m.proximaDosis.year == hoy.year &&
      m.proximaDosis.month == hoy.month &&
      m.proximaDosis.day == hoy.day
    ).toList();
  }

  MedicamentoProvider() {
    cargarMedicamentos();
  }

  double get progresoHoy {
    final hoy = medicamentosHoy;
    if (hoy.isEmpty) return 0.0;
    int tomados = hoy.where((m) => m.estado == 'Tomada').length;
    return tomados / hoy.length;
  }

  int get cantidadTomados => medicamentosHoy.where((m) => m.estado == 'Tomada').length;
  int get cantidadTotal => medicamentosHoy.length;

  Future<void> cargarMedicamentos() async {
    _medicamentos = await DBHelper.obtenerMedicamentos();
    notifyListeners();
  }

  Future<void> agregarMedicamento(Medicamento medicamento) async {
    await DBHelper.insertarMedicamento(medicamento);
    await cargarMedicamentos();
  }

  Future<void> agregarListaMedicamentos(List<Medicamento> lista) async {
    for (final med in lista) {
      await DBHelper.insertarMedicamento(med);
    }
    await cargarMedicamentos();
  }

  Future<void> eliminarMedicamento(String id) async {
    await DBHelper.eliminarMedicamento(id);
    await cargarMedicamentos();
  }

  Future<void> cambiarEstado(String id, String nuevoEstado) async {
    await DBHelper.actualizarEstado(id, nuevoEstado);
    await cargarMedicamentos();
  }
}