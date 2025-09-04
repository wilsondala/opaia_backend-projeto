import 'package:flutter/material.dart';
import '../models/car.dart';
import '../services/rent_service.dart';

class CarDetailScreen extends StatefulWidget {
  final Car car;
  final String token;

  const CarDetailScreen({Key? key, required this.car, required this.token})
      : super(key: key);

  @override
  State<CarDetailScreen> createState() => _CarDetailScreenState();
}

class _CarDetailScreenState extends State<CarDetailScreen> {
  bool _isLoading = false;

  void _rentCar() async {
    setState(() => _isLoading = true);

    try {
      await RentService.rentCar(
        carId: widget.car.id,
        startDate: '2025-08-20',
        endDate: '2025-08-25',
        token: widget.token,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Aluguel solicitado com sucesso!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao alugar: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final car = widget.car;

    return Scaffold(
      appBar: AppBar(title: Text('${car.marca} ${car.modelo}')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            car.imagemUrl != null && car.imagemUrl!.isNotEmpty
                ? Image.network(
                    'http://localhost:8000/uploads/${car.imagemUrl}',
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.directions_car, size: 200);
                    },
                  )
                : const Icon(Icons.directions_car, size: 200),
            const SizedBox(height: 16),
            Text('Marca: ${car.marca}', style: const TextStyle(fontSize: 18)),
            Text('Modelo: ${car.modelo}', style: const TextStyle(fontSize: 18)),
            Text('Ano: ${car.ano}', style: const TextStyle(fontSize: 18)),
            Text('Preço: R\$ ${car.preco.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 12),
            const Text('Descrição:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(car.descricao ?? '', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _rentCar,
                child: _isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text('Alugar Carro'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
