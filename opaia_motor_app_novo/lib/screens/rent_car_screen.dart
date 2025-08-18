import 'package:flutter/material.dart';

class RentCarScreen extends StatefulWidget {
  final int carId;
  final int userId;

  const RentCarScreen({Key? key, required this.carId, required this.userId}) : super(key: key);

  @override
  _RentCarScreenState createState() => _RentCarScreenState();
}

class _RentCarScreenState extends State<RentCarScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _startDate;
  DateTime? _endDate;

  // Função para mostrar DatePicker e escolher datas
  Future<void> _pickDate(BuildContext context, bool isStart) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: initialDate,
      lastDate: DateTime(initialDate.year + 1),
    );
    if (newDate != null) {
      setState(() {
        if (isStart) {
          _startDate = newDate;
        } else {
          _endDate = newDate;
        }
      });
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // Aqui você pode chamar o backend para criar o aluguel
      // Por enquanto, só vamos mostrar um dialog de sucesso
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Aluguel confirmado'),
          content: Text('Carro ${widget.carId} alugado de $_startDate até $_endDate'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  String? _validateDates() {
    if (_startDate == null || _endDate == null) {
      return 'Por favor, selecione as datas de início e fim';
    }
    if (_startDate!.isAfter(_endDate!)) {
      return 'Data de início deve ser antes da data de fim';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Alugar Carro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text('Alugando o carro id: ${widget.carId}'),
              SizedBox(height: 20),
              ListTile(
                title: Text(_startDate == null ? 'Selecionar data de início' : 'Início: ${_startDate!.toLocal()}'.split(' ')[0]),
                trailing: Icon(Icons.calendar_today),
                onTap: () => _pickDate(context, true),
              ),
              ListTile(
                title: Text(_endDate == null ? 'Selecionar data de fim' : 'Fim: ${_endDate!.toLocal()}'.split(' ')[0]),
                trailing: Icon(Icons.calendar_today),
                onTap: () => _pickDate(context, false),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final error = _validateDates();
                  if (error != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(error)),
                    );
                    return;
                  }
                  _submit();
                },
                child: Text('Confirmar Aluguel'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
