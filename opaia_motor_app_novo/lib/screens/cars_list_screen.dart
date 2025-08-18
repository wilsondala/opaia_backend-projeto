import 'package:flutter/material.dart';
import 'package:opaia_motor_app_novo/services/car_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CarsListScreen extends StatefulWidget {
  const CarsListScreen({super.key});

  @override
  State<CarsListScreen> createState() => _CarsListScreenState();
}

class _CarsListScreenState extends State<CarsListScreen> {
  List<dynamic> carros = [];
  bool carregando = false;
  String mensagemErro = '';

  @override
  void initState() {
    super.initState();
    carregarCarros();
  }

  Future<void> carregarCarros() async {
    setState(() {
      carregando = true;
      mensagemErro = '';
    });

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token == null) {
      setState(() {
        mensagemErro = 'Token não encontrado.';
        carregando = false;
      });
      return;
    }

    try {
      final resultado = await CarService.listarCarros(token);
      setState(() {
        carros = resultado;
      });
    } catch (e) {
      setState(() {
        mensagemErro = 'Erro ao carregar carros: $e';
      });
    } finally {
      setState(() {
        carregando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Carros'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: carregando
            ? const Center(child: CircularProgressIndicator())
            : mensagemErro.isNotEmpty
                ? Center(
                    child: Text(
                      mensagemErro,
                      style: const TextStyle(color: Colors.red, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView.builder(
                    itemCount: carros.length,
                    itemBuilder: (context, index) {
                      final carro = carros[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 3,
                        child: ListTile(
                          leading: Icon(
                            Icons.directions_car,
                            color: Theme.of(context).primaryColor,
                          ),
                          title: Text(
                            carro['modelo'] ?? 'Sem modelo',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text('Marca: ${carro['marca'] ?? 'Desconhecida'}'),
                          trailing: Text(
                            carro['ano']?.toString() ?? '',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
