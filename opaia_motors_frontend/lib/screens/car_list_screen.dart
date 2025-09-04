import 'package:flutter/material.dart';
import '../models/car.dart';
import '../services/car_service.dart';
import 'car_detail_screen.dart';
import 'car_create_screen.dart';

class CarListScreen extends StatefulWidget {
  final String token;

  const CarListScreen({Key? key, required this.token}) : super(key: key);

  @override
  State<CarListScreen> createState() => _CarListScreenState();
}

class _CarListScreenState extends State<CarListScreen> {
  late Future<List<Car>> _carsFuture;
  final CarService _carService = CarService(); // ⚡ Instância do serviço

  @override
  void initState() {
    super.initState();
    _carsFuture = _carService.getCars(widget.token); // chama via instância
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Carros'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CarCreateScreen(token: widget.token),
                ),
              ).then((_) {
                // Atualiza a lista ao voltar da tela de cadastro
                setState(() {
                  _carsFuture = _carService.getCars(widget.token);
                });
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Car>>(
        future: _carsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Erro ao carregar carros: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum carro encontrado.'));
          }

          final cars = snapshot.data!;
          return ListView.builder(
            itemCount: cars.length,
            itemBuilder: (context, index) {
              final car = cars[index];
              return ListTile(
                leading: car.imagemUrl != null && car.imagemUrl!.isNotEmpty
                    ? Image.network(
                        'http://localhost:8000/uploads/${car.imagemUrl}',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      )
                    : const Icon(Icons.directions_car, size: 60),
                title: Text('${car.marca} ${car.modelo}'),
                subtitle: Text('R\$ ${car.preco.toStringAsFixed(2)}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          CarDetailScreen(car: car, token: widget.token),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
