import 'dart:math';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";

  void _resetFields() {
    heightController.text = "";
    weightController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculateBmi() {
    setState(() {
      double height = double.parse(heightController.text) / 100;
      double weight = double.parse(weightController.text);
      double bmi = weight / pow(height, 2); // imc
      String bmiString = bmi.toStringAsFixed(2);

      if (bmi < 18.6) {
        _infoText = "Abaixo do peso ideal ($bmiString)";
      } else if (bmi >= 18.6 && bmi < 24.9) {
        _infoText = "Peso ideal ($bmiString)";
      } else if (bmi >= 24.9 && bmi < 29.9) {
        _infoText = "Levemente acima do peso ideal ($bmiString)";
      } else if (bmi >= 29.9 && bmi < 34.9) {
        _infoText = "Obesidade Grau I ($bmiString)";
      } else if (bmi >= 34.9 && bmi < 39.9) {
        _infoText = "Obesidade Grau II ($bmiString)";
      } else if (bmi >= 40) {
        _infoText = "Obesidade Grau III ($bmiString)";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: _resetFields,
              icon: const Icon(Icons.refresh),
            ),
          ],
          backgroundColor: Colors.green,
          centerTitle: true,
          title: const Text("Calculadora de IMC"),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.person_outline,
                  color: Colors.green,
                  size: 120.0,
                ),
                TextFormField(
                  controller: weightController,
                  decoration: const InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 25.0,
                  ),
                  textAlign: TextAlign.center,
                  validator: (value) =>
                      (value!.isEmpty ? "Insira seu peso!" : null),
                ),
                TextFormField(
                  controller: heightController,
                  decoration: const InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 25.0,
                  ),
                  textAlign: TextAlign.center,
                    validator: (value) =>
                    (value!.isEmpty ? "Insira sua altura!" : null),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                  ),
                  child: SizedBox(
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _calculateBmi();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      child: const Text(
                        "Calcular",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  _infoText,
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 25.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
