import 'package:flutter/material.dart';
import '../models/car.dart';

class CarCard extends StatelessWidget {
  final Car car;
  final VoidCallback onTap;

  const CarCard({Key? key, required this.car, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(car.imagemUrl,
            width: 50, height: 50, fit: BoxFit.cover),
        title: Text('${car.marca} ${car.modelo}'),
        subtitle: Text('R\$ ${car.preco.toStringAsFixed(2)}'),
        onTap: onTap,
      ),
    );
  }
}
