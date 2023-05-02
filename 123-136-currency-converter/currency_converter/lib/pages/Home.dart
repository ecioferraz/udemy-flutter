import 'package:currency_converter/main.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final dollarController = TextEditingController();
  final euroController = TextEditingController();
  final realController = TextEditingController();

  late double dollar;
  late double euro;

  void _onDollarChange(String value) {
    if (value.isEmpty) {
      _clearAll();
      return;
    }

    double dollar = double.parse(value);
    realController.text = (dollar * this.dollar).toStringAsFixed(2);
    euroController.text = ((dollar * this.dollar) / euro).toStringAsFixed(2);
  }

  void _onEuroChange(String value) {
    if (value.isEmpty) {
      _clearAll();
      return;
    }

    double euro = double.parse(value);
    dollarController.text = ((euro * this.euro) / dollar).toStringAsFixed(2);
    realController.text = (euro * this.euro).toStringAsFixed(2);
  }

  void _onRealChange(String value) {
    if (value.isEmpty) {
      _clearAll();
      return;
    }

    double real = double.parse(value);
    dollarController.text = (real / dollar).toStringAsFixed(2);
    euroController.text = (real / euro).toStringAsFixed(2);
  }

  void _clearAll() {
    dollarController.text = '';
    euroController.text = '';
    realController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        centerTitle: true,
        title: const Text('\$ Conversor \$'),
      ),
      body: FutureBuilder<Map>(
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                  child: Text(
                'Carregando dados...',
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 25,
                ),
                textAlign: TextAlign.center,
              ));
            default:
              if (snapshot.hasError) {
                return const Center(
                    child: Text(
                  'Erro ao carregar os dados :(',
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                ));
              } else {
                dollar = snapshot.data?['USD']['buy'];
                euro = snapshot.data?['EUR']['buy'];

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Icon(
                        Icons.monetization_on,
                        size: 150,
                        color: Colors.amber,
                      ),
                      buildTextField(
                          'Reais', 'R\$', realController, _onRealChange),
                      const Divider(),
                      buildTextField(
                          'Dólares', 'US\$', dollarController, _onDollarChange),
                      const Divider(),
                      buildTextField(
                          'Euros', '€', euroController, _onEuroChange),
                    ],
                  ),
                );
              }
          }
        },
        future: getData(),
      ),
    );
  }
}

Widget buildTextField(
  String label,
  String prefix,
  TextEditingController controller,
  Function(String) onChanged,
) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      border: const OutlineInputBorder(),
      labelText: label,
      labelStyle: const TextStyle(color: Colors.amber),
      prefixText: prefix,
    ),
    style: const TextStyle(
      color: Colors.amber,
      fontSize: 25,
    ),
    keyboardType: const TextInputType.numberWithOptions(decimal: true),
    onChanged: onChanged,
  );
}
