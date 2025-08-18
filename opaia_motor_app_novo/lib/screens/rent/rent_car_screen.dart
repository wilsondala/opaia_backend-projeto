import 'package:flutter/material.dart';
import 'package:opaia_motor_app/services/rent_service.dart';

class RentCarScreen extends StatefulWidget {
  final int carId;
  final int userId;

  const RentCarScreen({super.key, required this.carId, required this.userId});

  @override
  State<RentCarScreen> createState() => _RentCarScreenState();
}

class _RentCarScreenState extends State<RentCarScreen> {
  bool isLoading = false;
  String? mensagem;

  Future<void> rentCar() async {
    setState(() => isLoading = true);
    final result = await RentService.rentCar(widget.carId, widget.userId);
    setState(() {
      isLoading = false;
      mensagem = result ? "Aluguel realizado com sucesso!" : "Erro ao alugar carro.";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Alugar Carro")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Confirmar aluguel do carro?", style: TextStyle(fontSize: 18)),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: rentCar,
                      child: const Text("Confirmar Aluguel"),
                    ),
                    if (mensagem != null) ...[
                      const SizedBox(height: 20),
                      Text(mensagem!, style: const TextStyle(color: Colors.green)),
                    ]
                  ],
                ),
        ),
      ),
    );
  }
}
