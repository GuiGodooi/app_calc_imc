import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController kgcontroller = TextEditingController();
  TextEditingController cmcontroller = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = 'Informe seus dados!';

  void _resetFields() {
    kgcontroller.text = '';
    cmcontroller.text = '';
    setState(() {
      _infoText = 'Informe seus dados!';
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double kg = double.parse(kgcontroller.text);
      double cm = double.parse(cmcontroller.text) / 100;

      double imc = kg / (cm * cm);
      if (imc < 18.6) {
        _infoText = 'Abaixo do Peso = ${imc.toStringAsPrecision(4)}';
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = 'Peso ideal = ${imc.toStringAsPrecision(4)}';
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = 'Levemente acima do peso = ${imc.toStringAsPrecision(4)}';
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = 'Obesidade Grau I = ${imc.toStringAsPrecision(4)}';
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = 'Obesidade Grau II = ${imc.toStringAsPrecision(4)}';
      } else if (imc >= 40) {
        _infoText = 'Obesidade Grau III = ${imc.toStringAsPrecision(4)}';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        centerTitle: true,
        backgroundColor: Colors.yellow,
        title: const Text(
          'Calculardora de IMC',
          style: TextStyle(
            color: Colors.black,
            fontStyle: FontStyle.italic,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.refresh,
              color: Colors.black,
            ),
            onPressed: _resetFields,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 5),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                    top: 20,
                    bottom: 15,
                  ),
                  child: Icon(
                    Icons.person_outline,
                    size: 100,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Insira seu Peso!';
                      }
                    },
                    controller: kgcontroller,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    cursorColor: Colors.black,
                    style: const TextStyle(
                      fontSize: 35,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Peso (kg)',
                      labelStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Insira sua Altura!';
                      }
                    },
                    controller: cmcontroller,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    cursorColor: Colors.black,
                    style: const TextStyle(
                      fontSize: 35,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Altura (cm)',
                      labelStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 60,
                  width: 200,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(
                        10,
                      ),
                      backgroundColor: MaterialStateProperty.all(Colors.yellow),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            16,
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _calculate();
                      }
                    },
                    child: const Text(
                      'Calcular',
                      style: TextStyle(fontSize: 25, color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  _infoText,
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
