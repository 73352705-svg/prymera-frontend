import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/dashboard_provider.dart';

class AsesoresScreen extends ConsumerWidget {
  const AsesoresScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dash = ref.watch(dashboardProvider);
    final asesores = dash.data?['asesores'] as List? ?? [];

    return Scaffold(
      appBar: AppBar(title: const Text('Asesores')),
      body: dash.loading
          ? const Center(child: CircularProgressIndicator())
          : asesores.isEmpty
              ? const Center(child: Text('Sin datos'))
              : LayoutBuilder(
                  builder: (_, constraints) {
                    if (constraints.maxWidth > 600) return _table(asesores);
                    return _list(asesores);
                  },
                ),
    );
  }

  Widget _table(List asesores) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Asesor')),
          DataColumn(label: Text('Codigo')),
          DataColumn(label: Text('Agencia')),
          DataColumn(label: Text('Avance')),
        ],
        rows: asesores.map((a) => DataRow(cells: [
          DataCell(Text('${a['nombres']} ${a['apellidos']}')),
          DataCell(Text(a['codigo_empleado'])),
          DataCell(Text(a['agencia'] ?? '---')),
          DataCell(Text('${a['visitas_hoy']}/${a['total_asignados']}')),
        ])).toList(),
      ),
    );
  }

  Widget _list(List asesores) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: asesores.length,
      itemBuilder: (_, i) {
        final a = asesores[i];
        final total = a['total_asignados'] as int? ?? 0;
        final visitas = a['visitas_hoy'] as int? ?? 0;
        final pct = total > 0 ? visitas / total : 0.0;
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: CircleAvatar(backgroundColor: const Color(0xFF1B3670),
              child: Text((a['nombres'] as String)[0], style: const TextStyle(color: Colors.white))),
            title: Text('${a['nombres']} ${a['apellidos']}'),
            subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('${a['agencia'] ?? '---'} - ${a['codigo_empleado']}'),
              LinearProgressIndicator(value: pct, backgroundColor: Colors.grey[200],
                valueColor: const AlwaysStoppedAnimation(Color(0xFF2E7D32))),
              Text('$visitas/$total visitas', style: const TextStyle(fontSize: 11, color: Colors.grey)),
            ]),
          ),
        );
      },
    );
  }
}
