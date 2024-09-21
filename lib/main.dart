import 'package:flutter/material.dart';

void main(){
  runApp(Calculadora());
}

class Calculadora extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Calculadora",
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: CalculadoraHome(),
    );
  }
}

class CalculadoraHome extends StatefulWidget {
  @override
  CalculadoraHomeState createState() => CalculadoraHomeState();
}

class CalculadoraHomeState extends State<CalculadoraHome> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  String _resultado = '';
  String _operacao = '+';

  void calcular() {
    double? numero1 = double.tryParse(_controller1.text);
    double? numero2 = double.tryParse(_controller2.text);

    if (numero1 == null || numero2 == null) {
      setState(() {
        _resultado = 'Por favor, insira números válidos';
      });
      return;
    }

    double resultado = 0;

    if (_operacao == '+') {
      resultado = numero1 + numero2;
    } else if (_operacao == '-') {
      resultado = numero1 - numero2;
    } else if (_operacao == '*') {
      resultado = numero1 * numero2;
    } else if (_operacao == '/') {
      if (numero2 == 0) {
        setState(() {
          _resultado = 'Erro: Divisão por zero';
        });
        return;
      }
      resultado = numero1 / numero2;
    }

    setState(() {
      _resultado = 'Resultado: $resultado';
    });
  }

  void limparCampos() {
    setState(() {
      _controller1.clear();
      _controller2.clear();
      _resultado = '';
      _operacao = '+';
    });
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora Simples'),
      ),
      body: SingleChildScrollView( // Evita overflow em telas menores
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Primeiro número
            TextField(
              controller: _controller1,
              decoration: InputDecoration(
                labelText: 'Primeiro número',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 16),
            // Dropdown para selecionar a operação
            DropdownButtonFormField<String>(
              value: _operacao,
              decoration: InputDecoration(
                labelText: 'Operação',
                border: OutlineInputBorder(),
              ),
              onChanged: (String? newValue) {
                setState(() {
                  _operacao = newValue!;
                });
              },
              items: <String>['+', '-', '*', '/']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextStyle(fontSize: 20)),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            // Segundo número
            TextField(
              controller: _controller2,
              decoration: InputDecoration(
                labelText: 'Segundo número',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 24),
            // Botão de calcular
            ElevatedButton(
              onPressed: calcular,
              child: Text('Calcular', style: TextStyle(fontSize: 18)),
              style: ElevatedButton.styleFrom(
                padding:
                    EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
              ),
            ),
            SizedBox(height: 16),
            // Botão de limpar
            ElevatedButton(
              onPressed: limparCampos,
              child: Text('Limpar', style: TextStyle(fontSize: 18)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey, // Substituído 'primary' por 'backgroundColor'
                padding:
                    EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
              ),
            ),
            SizedBox(height: 24),
            // Exibição do resultado
            Text(
              _resultado,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
