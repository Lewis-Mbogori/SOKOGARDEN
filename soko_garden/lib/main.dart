import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:soko_garden/controller/shared_preferences.dart';

import 'screens/authentication.dart';
import 'screens/products.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // ensures resources are available
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // check if some data exists
  bool hasId = prefs.containsKey(PrefsNaming.username);
  runApp(MyApp(hasId: hasId));
}

class MyApp extends StatelessWidget {
  final bool hasId;
  const MyApp({super.key, required this.hasId});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Soko Garden',
      debugShowCheckedModeBanner: false,

      home:
          hasId ? const Products() : const Authentication(), // our Login Logic
    );
  }
}