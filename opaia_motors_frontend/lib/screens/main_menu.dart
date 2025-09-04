import 'package:flutter/material.dart';
import 'car_list_screen.dart';
import 'car_create_screen.dart';

class MainMenu extends StatelessWidget {
  // Token fixo enviado por você
  final String userToken =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3IiwiZXhwIjoxNzU2MTI3MjUwfQ.ChHVRMx3fX08jx3X1zVoU11SeRZ256xf8HmO3L3uMhM";

  MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Principal'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Opaia Motors',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.directions_car),
              title: const Text('Lista de Carros'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CarListScreen(token: userToken),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Cadastrar Carro'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CarCreateScreen(token: userToken),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Bem-vindo ao Opaia Motors!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CarListScreen(token: userToken),
                  ),
                );
              },
              icon: const Icon(Icons.directions_car),
              label: const Text('Ver Carros'),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CarCreateScreen(token: userToken),
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Cadastrar Carro'),
            ),
          ],
        ),
      ),
    );
  }
}
