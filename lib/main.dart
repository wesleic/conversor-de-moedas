import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async'; //requisição assíncrona
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance?format=json&key=c6c63a93";

void main() async {
  print(await getData());

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
    theme: ThemeData(hintColor: Colors.green, primaryColor: Colors.grey),
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();
  final pesoARGController = TextEditingController();
  final poundController = TextEditingController();
  final bitcoinController = TextEditingController();

  double dolar;
  double euro;
  double pesoARG;
  double pound;
  double bitcoin;

  void _clearAll() {
    realController.text = "";
    dolarController.text = "";
    euroController.text = "";
    pesoARGController.text = "";
    poundController.text = "";
    bitcoinController.text = "";
  }

  void _realChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double real = double.parse(text);
    dolarController.text = (real / dolar).toStringAsFixed(2);
    euroController.text = (real / euro).toStringAsFixed(2);
    pesoARGController.text = (real / pesoARG).toStringAsFixed(2);
    poundController.text = (real / pound).toStringAsFixed(2);
    bitcoinController.text = (real / bitcoin).toStringAsFixed(2);
  }

  void _dolarChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double dolar = double.parse(text);
    realController.text = (dolar * this.dolar).toStringAsFixed(2);
    euroController.text = (dolar * this.dolar / euro).toStringAsFixed(2);
    pesoARGController.text = (dolar * this.dolar / pesoARG).toStringAsFixed(2);
    poundController.text = (dolar * this.dolar / pound).toStringAsFixed(2);
    bitcoinController.text = (dolar * this.dolar / bitcoin).toStringAsFixed(2);
  }

  void _euroChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double euro = double.parse(text);
    realController.text = (euro * this.euro).toStringAsFixed(2);
    dolarController.text = (euro * this.euro / dolar).toStringAsFixed(2);
    pesoARGController.text = (euro * this.euro / pesoARG).toStringAsFixed(2);
    poundController.text = (euro * this.euro / pound).toStringAsFixed(2);
    bitcoinController.text = (euro * this.euro / bitcoin).toStringAsFixed(2);
  }

  void _pesoARGChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double pesoARG = double.parse(text);
    realController.text = (pesoARG * this.pesoARG).toStringAsFixed(2);
    euroController.text = (pesoARG * this.pesoARG / euro).toStringAsFixed(2);
    dolarController.text = (pesoARG * this.pesoARG / dolar).toStringAsFixed(2);
    poundController.text = (pesoARG * this.pesoARG / pound).toStringAsFixed(2);
    bitcoinController.text = (pesoARG * this.pesoARG / bitcoin).toStringAsFixed(2);
  }

  void _poundChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double pound = double.parse(text);
    realController.text = (pound * this.pound).toStringAsFixed(2);
    euroController.text = (pound * this.pound / euro).toStringAsFixed(2);
    dolarController.text = (pound * this.pound / dolar).toStringAsFixed(2);
    pesoARGController.text = (pound * this.pound / pesoARG).toStringAsFixed(2);
    bitcoinController.text = (pesoARG * this.pesoARG / bitcoin).toStringAsFixed(2);
  }

  void _bitcoinChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double bitcoin = double.parse(text);
    realController.text = (bitcoin * this.bitcoin).toStringAsFixed(2);
    euroController.text = (bitcoin * this.bitcoin / euro).toStringAsFixed(2);
    dolarController.text = (bitcoin * this.bitcoin / dolar).toStringAsFixed(2);
    pesoARGController.text = (bitcoin * this.bitcoin / pesoARG).toStringAsFixed(2);
    poundController.text = (bitcoin * this.bitcoin / pound).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "CONVERSOR",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
          future: getData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: Text(
                    'Carregando Dados...',
                    style: TextStyle(color: Colors.green, fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ),
                );
              default:
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Erro ao Carregar Dados :(',
                      style:
                      TextStyle(color: Colors.green, fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                  euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                  pesoARG =
                  snapshot.data["results"]["currencies"]["ARS"]["buy"];
                  pound = snapshot.data["results"]["currencies"]["GBP"]["buy"];
                  bitcoin = snapshot.data["results"]["currencies"]["BTC"]["buy"];
                  return SingleChildScrollView(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Icon(
                          Icons.monetization_on,
                          size: 150.0,
                          color: Colors.green,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        buildTextField(
                            "Reais", "R\$ ", realController, _realChanged),
                        Divider(
                          height: 25,
                        ),
                        buildTextField(
                            "Doláres", "US\$ ", dolarController, _dolarChanged),
                        Divider(
                          height: 25,
                        ),
                        buildTextField(
                            "Euros", "€ ", euroController, _euroChanged),
                        Divider(
                          height: 25,
                        ),
                        buildTextField(
                            "Libras", "£ ", poundController, _poundChanged),
                        Divider(
                          height: 25,
                        ),
                        buildTextField("Pesos ARG", "\$ ", pesoARGController,
                            _pesoARGChanged),
                        Divider(
                          height: 25,
                        ),
                        buildTextField("Bitcoins", "\$ ", bitcoinController,
                            _bitcoinChanged),
                      ],
                    ),
                  );
                }
            }
          }),
    );
  }
}

Widget buildTextField(
    String label, String prefix, TextEditingController valores, Function f) {
  return TextField(
    controller: valores,
    keyboardType: TextInputType.numberWithOptions(),
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.green,),
      border: OutlineInputBorder(),
      prefixText: prefix,
    ),
    style: TextStyle(color: Colors.green, fontSize: 25.0),
    onChanged: f,
  );
}
