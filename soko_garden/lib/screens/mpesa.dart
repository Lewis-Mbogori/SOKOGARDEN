import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:soko_garden/api/api.dart';


import 'products.dart';

class Mpesa extends StatefulWidget {
  const Mpesa({super.key});

  @override
  State<Mpesa> createState() => _MpesaState();
}

class _MpesaState extends State<Mpesa> {
  var amount = TextEditingController(text: '20');
  var phoneNumber = TextEditingController(text: '254757693623');
  var formKey = GlobalKey<FormState>();
  Future mpesa() async {
    try {
      var url = Uri.parse('$baseurl/api/mpesa');
      var body = jsonEncode({'amount': amount.text, 'phone': phoneNumber.text});
      var headers = {"Content-type": "application/json"};

      http.Response response =
          await http.post(url, body: body, headers: headers);
      if (response.statusCode == 200) {
        if (mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Successful')));
        } else {}
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Mpesa Transactions'), actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const Products()));
              },
              icon: const Icon(Icons.shop_outlined))
        ]),
        body: Form(
          key: formKey,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: amount,
                decoration: const InputDecoration(
                    labelText: 'Amount', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty || int.tryParse(value) == null) {
                    return 'Please enter a valid amount';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: phoneNumber,
                decoration: const InputDecoration(
                    labelText: 'Phone number',
                    hintText: 'e.g 254736252191',
                    border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty ||
                      int.tryParse(value) == null ||
                      value.length < 10) {
                    return 'Please enter a valid phone number';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    try {
                      mpesa();
                    } catch (e) {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())));
                      } else {}
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Please check your fields')));
                  }
                },
                child: const Text('Make payment'))
          ]),
        ));
  }
}