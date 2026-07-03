import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/asesores_screen.dart';
import 'screens/reportes_screen.dart';
import 'screens/mapa_screen.dart';

const Color primaryColor = Color(0xFF1B3670);
const Color secondaryColor = Color(0xFFFFCC00);
const Color background = Color(0xFFF6F4F5);

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
      GoRoute(path: '/dashboard', builder: (_, __) => const DashboardScreen()),
      GoRoute(path: '/asesores', builder: (_, __) => const AsesoresScreen()),
      GoRoute(path: '/reportes', builder: (_, __) => const ReportesScreen()),
      GoRoute(path: '/mapa', builder: (_, __) => const MapaScreen()),
    ],
  );
});

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'Prymera — Supervision',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor, primary: primaryColor, secondary: secondaryColor),
        scaffoldBackgroundColor: background,
        appBarTheme: const AppBarTheme(backgroundColor: primaryColor, foregroundColor: Colors.white, elevation: 0),
      ),
      routerConfig: router,
    );
  }
}
