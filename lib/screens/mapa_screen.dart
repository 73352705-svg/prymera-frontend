import 'package:flutter/material.dart';

class MapaScreen extends StatelessWidget {
  const MapaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mapa de supervision')),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFE8EAF6),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.map, size: 64, color: Color(0xFF1B3670)),
              const SizedBox(height: 16),
              const Text('Mapa de supervision en tiempo real', style: TextStyle(fontSize: 18, color: Color(0xFF1B3670))),
              const SizedBox(height: 8),
              Text('Requiere integracion con Google Maps', style: TextStyle(color: Colors.grey[600])),
              const SizedBox(height: 24),
              Wrap(spacing: 8, children: [
                _legend(const Color(0xFFE52421), 'Maria Q.'),
                _legend(const Color(0xFFF57C00), 'Jose M.'),
                _legend(const Color(0xFF2E7D32), 'Rosa C.'),
                _legend(const Color(0xFF1976D2), 'Pedro C.'),
              ]),
              const SizedBox(height: 24),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 32),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(children: [
                    _locRow('Maria Quispe', 'Av. Ejercito 450', 'Visitando'),
                    const Divider(),
                    _locRow('Jose Mamani', 'Calle Lima 123', 'En transito'),
                    const Divider(),
                    _locRow('Rosa Condori', 'Av. La Paz 780', 'Completado'),
                    const Divider(),
                    _locRow('Pedro Ccahua', 'Jr. Cusco 345', 'En pausa'),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _legend(Color color, String label) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
      const SizedBox(width: 4),
      Text(label, style: const TextStyle(fontSize: 12)),
    ]);
  }

  Widget _locRow(String name, String dir, String status) {
    return Row(children: [
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        Text(dir, style: const TextStyle(fontSize: 11, color: Colors.grey)),
      ])),
      Chip(label: Text(status, style: const TextStyle(fontSize: 10)), padding: EdgeInsets.zero),
    ]);
  }
}
