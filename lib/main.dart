import 'package:currency_converter/services/api_client.dart';
import 'package:currency_converter/widget/drop_down.dart';
import 'package:flutter/material.dart';
import 'constraints.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CurrencyConverter(),
    );
  }
}

class CurrencyConverter extends StatefulWidget {
  const CurrencyConverter({Key? key}) : super(key: key);

  @override
  State<CurrencyConverter> createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  // make API client
  ApiClient client = ApiClient();
  //Setting Variables
  late List<String> currencies;
  late String from;
  late String to;
  // variable for exchange rate
  late double rate;
  String result = "";
  // call API
  Future<List<String>> getCurrencyList() async {
    return await client.getCurrencies();
  }

  @override
  initState() {
    super.initState();
    (() async {
      List<String> list = await client.getCurrencies();
      setState(() {
        currencies = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Currency Converter',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: secondaryColor,
        shadowColor: Colors.blue,
      ),
      backgroundColor: primaryColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                onSubmitted: (value) async {
                  rate = await client.getRate(from, to);
                  setState(() {
                    result = (double.parse(value)).toStringAsFixed(3);
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: textColor,
                  labelText: "Input value to convert",
                  contentPadding: const EdgeInsets.all(15),
                  focusedBorder: InputBorder.none,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 18,
                    color: secondaryColor,
                  ),
                ),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  customDropDown(
                    currencies,
                    from,
                    (val) {
                      setState(() {
                        from = val;
                      });
                    },
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      String temp = 'from';
                      setState(() {
                        from = to;
                        to = temp;
                      });
                    },
                    elevation: 0.0,
                    backgroundColor: secondaryColor,
                    child: const Icon(Icons.swap_horiz),
                  ),
                  customDropDown(
                    currencies,
                    to,
                    (val) {
                      setState(() {
                        to = val;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Result',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      result,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 36,
                        color: secondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
