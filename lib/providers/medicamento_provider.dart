import 'package:flutter/material.dart';
import '../models/medicamento.dart';
import '../services/db_helper.dart';

class MedicamentoProvider extends ChangeNotifier {
  List<Medicamento> _medicamentos = [];

  List<Medicamento> get medicamentos => _medicamentos;

  MedicamentoProvider() {
    cargarMedicamentos();
  }

  double get progresoHoy {
    if (_medicamentos.isEmpty) return 0.0;
    int tomados = _medicamentos.where((m) => m.estado == 'Tomada').length;
    return tomados / _medicamentos.length;
  }
  int get cantidadTomados => _medicamentos.where((m) => m.estado == 'Tomada').length;
  int get cantidadTotal => _medicamentos.length;

  Future<void> cargarMedicamentos() async {
    _medicamentos = await DBHelper.obtenerMedicamentos();
    notifyListeners();
  }

  Future<void> agregarMedicamento(Medicamento medicamento) async {
    await DBHelper.insertarMedicamento(medicamento);
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