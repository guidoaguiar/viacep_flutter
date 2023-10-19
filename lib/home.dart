import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _cepController = TextEditingController();
  String _cepInfo = '';

  Future<void> _recuperarCep() async {
    String cep = _cepController.text;
    String url = 'http://viacep.com.br/ws/$cep/json/';

    http.Response response = await http.get(Uri.parse(url));

    Map<String, dynamic> retorno = json.decode(response.body);
    String uf = retorno['uf'];
    String localidade = retorno['localidade'];
    String logradouro = retorno['logradouro'];
    String bairro = retorno['bairro'];
    String ddd = retorno['ddd'];

    setState(() {
      _cepInfo =
          'UF: $uf\n Localidade: $localidade \n Logradouro: $logradouro \nBairro: $bairro\nDDD: $ddd';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Procure o CEP que precisa'),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "BEM VINDO AO BUSCADOR DE CEP BRASILEIROS",
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Icon(
                Icons.map_rounded,
                color: Colors.black12,
              ),
              Expanded(
                child: Container(
                  color: Colors.black12,
                  child: TextField(
                    controller: _cepController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration:
                        const InputDecoration(labelText: 'ex: 01001-000'),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _recuperarCep,
            child: Text('Clique Aqui',
                style: TextStyle(color: Colors.purpleAccent[300])),
          ),
          const SizedBox(height: 20),
          Text('CEP recuperado:\n$_cepInfo', textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
