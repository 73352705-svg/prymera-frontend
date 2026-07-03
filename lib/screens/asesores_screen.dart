import 'package:flutter/material.dart';

class AsesoresScreen extends StatelessWidget {
  const AsesoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final asesores = [
      {'nombre': 'Maria Quispe Huaman', 'codigo': 'EMP001', 'agencia': 'Agencia Arequipa', 'visitados': 5, 'total': 8, 'ultima_sync': '10:30'},
      {'nombre': 'Jose Mamani Flores', 'codigo': 'EMP002', 'agencia': 'Agencia Arequipa', 'visitados': 3, 'total': 6, 'ultima_sync': '10:15'},
      {'nombre': 'Rosa Condori Apaza', 'codigo': 'EMP003', 'agencia': 'Agencia Cusco', 'visitados': 6, 'total': 7, 'ultima_sync': '10:45'},
      {'nombre': 'Pedro Ccahua Ramos', 'codigo': 'EMP004', 'agencia': 'Agencia Cusco', 'visitados': 2, 'total': 5, 'ultima_sync': '09:50'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Asesores')),
      body: LayoutBuilder(
        builder: (_, constraints) {
          if (constraints.maxWidth > 600) {
            return _table(asesores);
          }
          return _list(asesores);
        },
      ),
    );
  }

  Widget _table(List list) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Asesor')),
          DataColumn(label: Text('Codigo')),
          DataColumn(label: Text('Agencia')),
          DataColumn(label: Text('Avance')),
          DataColumn(label: Text('Ult. Sync')),
        ],
        rows: list.map((a) => DataRow(cells: [
          DataCell(Text(a['nombre'] as String)),
          DataCell(Text(a['codigo'] as String)),
          DataCell(Text(a['agencia'] as String)),
          DataCell(Text('${a['visitados']}/${a['total']}')),
          DataCell(Text(a['ultima_sync'] as String)),
        ])).toList(),
      ),
    );
  }

  Widget _list(List list) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: list.length,
      itemBuilder: (_, i) {
        final a = list[i];
        final pct = (a['visitados'] as int) / (a['total'] as int);
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: CircleAvatar(backgroundColor: const Color(0xFF1B3670),
              child: Text((a['nombre'] as String)[0], style: const TextStyle(color: Colors.white))),
            title: Text(a['nombre'] as String),
            subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('${a['agencia']} — ${a['codigo']}'),
              LinearProgressIndicator(value: pct, backgroundColor: Colors.grey[200],
                valueColor: const AlwaysStoppedAnimation(Color(0xFF2E7D32))),
              Text('${a['visitados']}/${a['total']} visitas — Sync: ${a['ultima_sync']}',
                style: const TextStyle(fontSize: 11, color: Colors.grey)),
            ]),
          ),
        );
      },
    );
  }
}
