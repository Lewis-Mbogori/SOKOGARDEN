// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:soko_garden/screens/products.dart';

import '../../controller/users.dart';

class Login extends StatefulWidget {
  final VoidCallback onClickedSignup;
  const Login({
    super.key,
    required this.onClickedSignup,
  });

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();

  var username = TextEditingController();
  var password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Log In')),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      controller: username,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter a password';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      controller: password,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.password),
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter a password';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ],
              )),
          ElevatedButton(
              onPressed: () {
                var isValid = formKey.currentState!.validate();
                if (isValid) {
                  login(username.text, password.text).then((v) {
                    if (v == 'Successfully') {
                      // Go to products
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => const Products()));
                    } else {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(v.toString())));
                    }
                  });
                }
              },
              child: const Text('Log In')),
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: "Don't have an account? ",
                style: Theme.of(context).textTheme.bodyMedium),
            TextSpan(
                text: 'Signup',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(decoration: TextDecoration.underline),
                recognizer: TapGestureRecognizer()
                  ..onTap = widget.onClickedSignup)
          ]))
        ],
      ),
    );
  }
}