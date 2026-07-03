import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/api_client.dart';

class AuthState {
  final bool loggedIn;
  final String? error;
  final bool loading;
  final Map<String, dynamic>? asesor;

  const AuthState({this.loggedIn = false, this.error, this.loading = false, this.asesor});

  AuthState copyWith({bool? loggedIn, String? error, bool? loading, Map<String, dynamic>? asesor}) {
    return AuthState(
      loggedIn: loggedIn ?? this.loggedIn,
      error: error,
      loading: loading ?? this.loading,
      asesor: asesor ?? this.asesor,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState());

  Future<void> login(String codigo, String password) async {
    state = state.copyWith(loading: true, error: null);
    try {
      final data = await apiClient.post('/auth/login', {
        'codigo_empleado': codigo,
        'password': password,
      });
      apiClient.setToken(data['access_token']);
      state = state.copyWith(loggedIn: true, loading: false, asesor: data['asesor']);
    } on ApiException catch (e) {
      state = state.copyWith(loading: false, error: e.message);
    } catch (e) {
      state = state.copyWith(loading: false, error: 'Error de conexion');
    }
  }

  void logout() {
    apiClient.clearToken();
    state = const AuthState();
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) => AuthNotifier());
