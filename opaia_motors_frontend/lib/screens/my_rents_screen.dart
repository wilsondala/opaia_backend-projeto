import 'package:flutter/material.dart';
import '../services/rent_service.dart';
import '../models/rent.dart';

class MyRentsScreen extends StatefulWidget {
  final String token;

  const MyRentsScreen({Key? key, required this.token}) : super(key: key);

  @override
  State<MyRentsScreen> createState() => _MyRentsScreenState();
}

class _MyRentsScreenState extends State<MyRentsScreen> {
  late Future<List<Rent>> _rentsFuture;

  @override
  void initState() {
    super.initState();
    _rentsFuture = RentService.getMyRents(token: widget.token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meus Aluguéis')),
      body: FutureBuilder<List<Rent>>(
        future: _rentsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Erro ao carregar alugueis:\n${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum aluguel encontrado.'));
          }

          final rents = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: rents.length,
            itemBuilder: (context, index) {
              final rent = rents[index];
              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  title: Text('Carro ID: ${rent.carId}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Início: ${rent.startDate}'),
                      Text('Fim: ${rent.endDate}'),
                      Text('Status: ${rent.status}'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
