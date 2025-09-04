import 'package:flutter/material.dart';
import 'package:opaia_motors_frontend/screens/car_list_screen.dart';
import 'package:opaia_motors_frontend/screens/car_create_screen.dart';
import 'package:opaia_motors_frontend/screens/my_rents_screen.dart';
import 'package:opaia_motors_frontend/screens/login_screen.dart';

class HomeScreen extends StatelessWidget {
  final String userToken; // ⚡ obrigatório

  const HomeScreen({Key? key, required this.userToken}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Opaia Motors'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            // Lista de carros
            ListTile(
              leading: const Icon(Icons.car_rental),
              title: const Text('Carros'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CarListScreen(token: userToken),
                  ),
                );
              },
            ),
            // Cadastro de carro
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Cadastrar Carro'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CarCreateScreen(token: userToken),
                  ),
                );
              },
            ),
            // Meus aluguéis
            ListTile(
              leading: const Icon(Icons.list_alt),
              title: const Text('Meus Aluguéis'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyRentsScreen(token: userToken),
                  ),
                );
              },
            ),
            // Logout
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bem-vindo ao Opaia Motors!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text('Use o menu lateral para navegar.'),
          ],
        ),
      ),
    );
  }
}
