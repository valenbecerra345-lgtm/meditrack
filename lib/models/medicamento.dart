class Medicamento {
  final String id;
  final String nombre;
  final String dosis;
  final String frecuencia; 
  final DateTime proximaDosis;
  String estado; 

  Medicamento({
    required this.id,
    required this.nombre,
    required this.dosis,
    required this.frecuencia,
    required this.proximaDosis,
    this.estado = 'Pendiente',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'dosis': dosis,
      'frecuencia': frecuencia,
      'proximaDosis': proximaDosis.toIso8601String(), 
      'estado': estado,
    };
  }

  factory Medicamento.fromMap(Map<String, dynamic> map) {
    return Medicamento(
      id: map['id'],
      nombre: map['nombre'],
      dosis: map['dosis'],
      frecuencia: map['frecuencia'],
      proximaDosis: DateTime.parse(map['proximaDosis']),
      estado: map['estado'],
    );
  }
}