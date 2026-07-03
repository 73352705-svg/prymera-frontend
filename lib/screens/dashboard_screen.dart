import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/dashboard_provider.dart';
import '../providers/auth_provider.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});
  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(dashboardProvider.notifier).cargar());
  }

  @override
  Widget build(BuildContext context) {
    final dash = ref.watch(dashboardProvider);
    final auth = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Prymera — Supervision'), actions: [
        IconButton(icon: const Icon(Icons.logout), onPressed: () {
          ref.read(authProvider.notifier).logout();
          context.go('/login');
        }),
      ]),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF242F7B), Color(0xFF3569AD)])),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.end, children: [
                const Icon(Icons.analytics, size: 48, color: Colors.white),
                Text(auth.asesor?['nombres'] ?? 'Supervisor', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                const Text('Panel de control', style: TextStyle(color: Colors.white70, fontSize: 13)),
              ]),
            ),
            ListTile(leading: const Icon(Icons.dashboard), title: const Text('Dashboard'), onTap: () => context.pop()),
            ListTile(leading: const Icon(Icons.people), title: const Text('Asesores'), onTap: () { context.pop(); context.push('/asesores'); }),
            ListTile(leading: const Icon(Icons.bar_chart), title: const Text('Reportes'), onTap: () { context.pop(); context.push('/reportes'); }),
            ListTile(leading: const Icon(Icons.map), title: const Text('Mapa'), onTap: () { context.pop(); context.push('/mapa'); }),
          ],
        ),
      ),
      body: dash.loading
          ? const Center(child: CircularProgressIndicator())
          : dash.error != null
              ? Center(child: Text('Error: ${dash.error}', style: const TextStyle(color: Colors.red)))
              : _buildBody(dash.data!),
    );
  }

  Widget _buildBody(Map<String, dynamic> data) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Resumen del dia', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 16),
          Row(children: [
            _kpi('Asesores activos', '${data['total_asesores_activos']}', Icons.people, const Color(0xFF1B3670)),
            const SizedBox(width: 12),
            _kpi('Visitas hoy', '${data['visitas_hoy']}', Icons.check_circle, const Color(0xFF2E7D32)),
            const SizedBox(width: 12),
            _kpi('Pendientes', '${data['pendientes']}', Icons.pending, const Color(0xFFF57C00)),
            const SizedBox(width: 12),
            _kpi('Solicitudes', '${data['solicitudes_enviadas']}', Icons.description, const Color(0xFF1976D2)),
          ]),
          const SizedBox(height: 24),
          Text('Actividad reciente', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Expanded(child: _actividad(data['actividad_reciente'] ?? [])),
        ],
      ),
    );
  }

  Widget _actividad(List items) {
    if (items.isEmpty) return const Center(child: Text('Sin actividad reciente', style: TextStyle(color: Colors.grey)));
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (_, i) {
        final item = items[i];
        return ListTile(
          leading: CircleAvatar(backgroundColor: const Color(0xFF1B3670),
            child: Text((item['asesor_nombre'] as String)[0], style: const TextStyle(color: Colors.white))),
          title: Text('${item['asesor_nombre']} ${item['accion']}'),
          trailing: Text(item['tiempo'], style: const TextStyle(color: Colors.grey, fontSize: 12)),
        );
      },
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
}
