import 'package:flutter/material.dart';
import '../models/car.dart';
import '../services/car_service.dart';

class CarCreateScreen extends StatefulWidget {
  final String token;

  const CarCreateScreen({Key? key, required this.token}) : super(key: key);

  @override
  State<CarCreateScreen> createState() => _CarCreateScreenState();
}

class _CarCreateScreenState extends State<CarCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _marcaController = TextEditingController();
  final _modeloController = TextEditingController();
  final _anoController = TextEditingController();
  final _precoController = TextEditingController();
  final _descricaoController = TextEditingController();

  final CarService _carService = CarService(); // ✅ instância do serviço

  bool _isLoading = false;

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      Car newCar = await _carService.createCar(
        marca: _marcaController.text,
        modelo: _modeloController.text,
        ano: int.parse(_anoController.text),
        preco: double.parse(_precoController.text),
        descricao: _descricaoController.text,
        token: widget.token,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Carro cadastrado: ${newCar.marca} ${newCar.modelo}'),
        ),
      );

      _formKey.currentState!.reset();
      _marcaController.clear();
      _modeloController.clear();
      _anoController.clear();
      _precoController.clear();
      _descricaoController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao cadastrar carro: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _marcaController.dispose();
    _modeloController.dispose();
    _anoController.dispose();
    _precoController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar Carro')),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _marcaController,
                  decoration: const InputDecoration(labelText: 'Marca'),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Informe a marca' : null,
                ),
                TextFormField(
                  controller: _modeloController,
                  decoration: const InputDecoration(labelText: 'Modelo'),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Informe o modelo' : null,
                ),
                TextFormField(
                  controller: _anoController,
                  decoration: const InputDecoration(labelText: 'Ano'),
                  keyboardType: TextInputType.number,
                  validator: (v) => v == null || int.tryParse(v) == null
                      ? 'Ano inválido'
                      : null,
                ),
                TextFormField(
                  controller: _precoController,
                  decoration: const InputDecoration(labelText: 'Preço'),
                  keyboardType: TextInputType.number,
                  validator: (v) => v == null || double.tryParse(v) == null
                      ? 'Preço inválido'
                      : null,
                ),
                TextFormField(
                  controller: _descricaoController,
                  decoration: const InputDecoration(labelText: 'Descrição'),
                  maxLines: 2,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Cadastrar Carro'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
