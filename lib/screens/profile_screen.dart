import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/medicamento_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notificaciones = true;
  bool _sonidos = true;

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<MedicamentoProvider>(context);

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          const Text('PERFIL', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.blueAccent,
                  child: Icon(Icons.person, size: 40, color: Colors.white),
                ),
                const SizedBox(height: 10),
                const Text('Maria Gonzalez', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const Text('maria@gmail.com', style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStat(prov.cantidadTotal.toString(), 'Medicamentos', Colors.blue),
                    _buildStat(prov.cantidadTomados.toString(), 'Tomados hoy', Colors.green),
                    _buildStat('7', 'Racha', Colors.orange), // Dato estático por ahora
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('PREFERENCIAS RÁPIDAS', style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Notificaciones', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: const Text('Recordatorios de toma', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  secondary: const Icon(Icons.notifications_active_outlined),
                  value: _notificaciones,
                  activeThumbColor: Colors.blue,
                  onChanged: (val) => setState(() => _notificaciones = val),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Sonidos', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: const Text('Alertas sonoras', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  secondary: const Icon(Icons.volume_up_outlined),
                  value: _sonidos,
                  activeThumbColor: Colors.blue,
                  onChanged: (val) => setState(() => _sonidos = val),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('MI CUENTA', style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                _buildAccountOption(Icons.person_outline, 'Información personal', 'Edita tu nombre, correo y datos personales'),
                const Divider(),
                _buildAccountOption(Icons.lock_outline, 'Privacidad y seguridad', 'Configura tu contraseña y permisos'),
                const Divider(),
                _buildAccountOption(Icons.help_outline, 'Ayuda y soporte', 'Preguntas frecuentes y asistencia'),
                const Divider(),
                _buildAccountOption(Icons.info_outline, 'Acerca de la aplicación', 'Versión 1.0.0'),
              ],
            ),
          ),
          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade50,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 0,
            ),
            child: const Text('Cerrar Sesión', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16)),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildStat(String value, String label, Color color) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }

  Widget _buildAccountOption(IconData icon, String title, String subtitle) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.black87),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: () {},
    );
  }
}