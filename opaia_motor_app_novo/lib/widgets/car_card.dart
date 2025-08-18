import 'package:flutter/material.dart';
import 'rent_car_screen.dart'; // importe a tela de aluguel

class CarCard extends StatelessWidget {
  final int carId;  // novo: id do carro para navegar
  final int userId; // novo: id do usuário (pode ser opcional, dependendo da sua lógica)
  final String nome;
  final String marca;
  final int ano;
  final double preco;
  final String descricao;

  const CarCard({
    super.key,
    required this.carId,
    required this.userId,
    required this.nome,
    required this.marca,
    required this.ano,
    required this.preco,
    required this.descricao,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nome,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text("Marca: $marca"),
            Text("Ano: $ano"),
            Text("Preço: ${preco.toStringAsFixed(2)} Kz"),
            const SizedBox(height: 8),
            Text(descricao),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RentCarScreen(carId: carId, userId: userId),
                    ),
                  );
                },
                child: const Text('Alugar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
