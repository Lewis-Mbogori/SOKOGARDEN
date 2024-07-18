import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:soko_garden/api/api.dart';

import '../api/products.dart';

Future fetchProductbyId(int id) async {
  http.Response feedback = await http.post(
      Uri.parse(
        '$baseurl/api/single_item',
      ),
      headers: {'Content-type': 'application/json'},
      body: json.encode({'id': id}));
  if (feedback.statusCode == 200) {
    return json.decode(feedback.body);
  } else {
    // Toast
    return null;
  }
}

// PASTE SAMPLE RESPONSE HERE
// [
//     9,
//     "Samsung Galaxy Note 10",
//     "RAM 64Gb,Storage 256GB",
//     117000,
//     "Smartphones",
//     "Samsung Galaxy Note 10.jpg"
// ]

Future getproducts() async {
  http.Response response = await http.get(Uri.parse('$baseurl/api/products'));
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    return null;
  }
}

// PASTE SAMPLE RESPONSE HERE
//  [
//         1,
//         "Samsung A03",
//         "RAM 16GB, Storage 128GB",
//         32000,
//         "Smartphones",
//         "phone1.jpg"
//     ],
//     [
//         2,
//         "Oppo Reno 7",
//         "RAM 32GB,Storage 128GB",
//         21000,
//         "Smartphones",
//         "phone6.jpg"
//     ],

Future createProduct(Map product) async {
  try {
    http.Response response = await http.post(Uri.parse('$baseurl/api/create'),
        body: json.encode(product),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
      // Toast
    } else {}
  } catch (e) {
    return e;
  }
}