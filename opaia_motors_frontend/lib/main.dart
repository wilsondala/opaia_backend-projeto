import 'package:flutter/material.dart';

// Import das telas
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/car_list_screen.dart';
import 'screens/car_detail_screen.dart';
import 'screens/my_rents_screen.dart';
import 'screens/car_create_screen.dart'; // ✅ Tela de cadastro de carro

// Import do tema centralizado
import 'theme/theme.dart';

const String fixedToken =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3IiwiZXhwIjoxNzU2MTI3MjUwfQ.ChHVRMx3fX08jx3X1zVoU11SeRZ256xf8HmO3L3uMhM";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const OpaiaMotorsApp());
}

class OpaiaMotorsApp extends StatelessWidget {
  const OpaiaMotorsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Opaia Motors',
      theme: AppTheme.lightTheme,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => HomeScreen(userToken: fixedToken),
        '/cars': (context) => CarListScreen(token: fixedToken),
      },
      onGenerateRoute: (settings) {
        // Detalhes do carro
        if (settings.name == '/car_detail') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => CarDetailScreen(
              car: args['car'],
              token: args['token'],
            ),
          );
        }

        // Meus aluguéis
        if (settings.name == '/my_rents') {
          final token = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) => MyRentsScreen(token: token),
          );
        }

        // Cadastro de carro
        if (settings.name == '/car_create') {
          final token = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) => CarCreateScreen(token: token),
          );
        }

        return null;
      },
    );
  }
}
