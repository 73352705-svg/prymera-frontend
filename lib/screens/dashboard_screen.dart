import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Prymera — Supervision'), actions: [
        IconButton(icon: const Icon(Icons.logout), onPressed: () => context.go('/login')),
      ]),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF242F7B), Color(0xFF3569AD)])),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.end, children: [
                Icon(Icons.analytics, size: 48, color: Colors.white),
                Text('Supervisor', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                Text('Panel de control', style: TextStyle(color: Colors.white70, fontSize: 13)),
              ]),
            ),
            ListTile(leading: const Icon(Icons.dashboard), title: const Text('Dashboard'), onTap: () => context.pop()),
            ListTile(leading: const Icon(Icons.people), title: const Text('Asesores'), onTap: () => context.push('/asesores')),
            ListTile(leading: const Icon(Icons.bar_chart), title: const Text('Reportes'), onTap: () => context.push('/reportes')),
            ListTile(leading: const Icon(Icons.map), title: const Text('Mapa'), onTap: () => context.push('/mapa')),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Resumen del dia', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            Row(children: [
              _kpi('Asesores activos', '12', Icons.people, const Color(0xFF1B3670)),
              const SizedBox(width: 12),
              _kpi('Visitas hoy', '48', Icons.check_circle, const Color(0xFF2E7D32)),
              const SizedBox(width: 12),
              _kpi('Pendientes', '23', Icons.pending, const Color(0xFFF57C00)),
              const SizedBox(width: 12),
              _kpi('Solicitudes', '15', Icons.description, const Color(0xFF1976D2)),
            ]),
            const SizedBox(height: 24),
            Text('Actividad reciente', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Expanded(child: ListView(children: [
              _act('Maria Quispe', 'Completo visita', 'hace 10 min'),
              _act('Jose Mamani', 'Registro solicitud', 'hace 25 min'),
              _act('Rosa Condori', 'Marco visita como completada', 'hace 40 min'),
              _act('Pedro Ccahua', 'Envio solicitud al comite', 'hace 1 h'),
            ])),
          ],
        ),
      ),
    );
  }

  Widget _kpi(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
            Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey), textAlign: TextAlign.center),
          ]),
        ),
      ),
    );
  }

  Widget _act(String who, String action, String time) {
    return ListTile(
      leading: CircleAvatar(backgroundColor: const Color(0xFF1B3670),
        child: Text(who[0], style: const TextStyle(color: Colors.white))),
      title: Text('$who $action'),
      trailing: Text(time, style: const TextStyle(color: Colors.grey, fontSize: 12)),
    );
  }
}
