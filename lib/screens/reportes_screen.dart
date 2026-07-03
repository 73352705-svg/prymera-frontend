import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ReportesScreen extends StatelessWidget {
  const ReportesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reportes')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Productividad mensual', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 20,
                  barGroups: [
                    _bar(0, 'Maria', 8, 5, 4),
                    _bar(1, 'Jose', 6, 3, 3),
                    _bar(2, 'Rosa', 7, 4, 3),
                    _bar(3, 'Pedro', 5, 2, 1),
                  ],
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 30)),
                    bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (v, _) {
                      const names = ['Maria', 'Jose', 'Rosa', 'Pedro'];
                      return Text(names[v.toInt()], style: const TextStyle(fontSize: 10));
                    })),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: true, drawVerticalLine: false),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text('Tabla comparativa', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                child: DataTable(columns: const [
                  DataColumn(label: Text('Asesor')),
                  DataColumn(label: Text('Enviadas')),
                  DataColumn(label: Text('Aprobadas')),
                  DataColumn(label: Text('Desemb.')),
                  DataColumn(label: Text('Tasa')),
                ], rows: [
                  _dataRow('Maria Q.', 8, 5, 4, '62.5%'),
                  _dataRow('Jose M.', 6, 3, 3, '50.0%'),
                  _dataRow('Rosa C.', 7, 4, 3, '57.1%'),
                  _dataRow('Pedro C.', 5, 2, 1, '40.0%'),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData _bar(int x, String _, double enviadas, double aprobadas, double desembolsadas) {
    return BarChartGroupData(x: x, barRods: [
      BarChartRodData(toY: enviadas, color: const Color(0xFF1976D2), width: 8),
      BarChartRodData(toY: aprobadas, color: const Color(0xFF2E7D32), width: 8),
      BarChartRodData(toY: desembolsadas, color: const Color(0xFFFFCC00), width: 8),
    ]);
  }

  DataRow _dataRow(String name, int e, int a, int d, String tasa) {
    return DataRow(cells: [
      DataCell(Text(name)),
      DataCell(Text('$e')),
      DataCell(Text('$a')),
      DataCell(Text('$d')),
      DataCell(Text(tasa)),
    ]);
  }
}
