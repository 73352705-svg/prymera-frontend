import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/api_client.dart';

class DashboardState {
  final Map<String, dynamic>? data;
  final bool loading;
  final String? error;

  const DashboardState({this.data, this.loading = false, this.error});
}

class DashboardNotifier extends StateNotifier<DashboardState> {
  DashboardNotifier() : super(const DashboardState());

  Future<void> cargar() async {
    state = DashboardState(loading: true);
    try {
      final data = await apiClient.get('/supervisor/resumen');
      state = DashboardState(data: data);
    } on ApiException catch (e) {
      state = DashboardState(error: e.message);
    } catch (e) {
      state = DashboardState(error: 'Error de conexion');
    }
  }
}

final dashboardProvider = StateNotifierProvider<DashboardNotifier, DashboardState>((ref) => DashboardNotifier());
