import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:soko_garden/screens/mpesa.dart';
import 'package:soko_garden/screens/products.dart';

import '../controller/products.dart';

class Oneproduct extends StatefulWidget {
  const Oneproduct({super.key, required this.product_id});
  final int product_id;
  @override
  State<Oneproduct> createState() => _OneproductState();
}

class _OneproductState extends State<Oneproduct> {
  @override
  Widget build(BuildContext context) {
    // a future builder - widget that builds itself based on the latest snapshot of interaction with a future

    // 1. FUTURE - an object representing a potential value or error
    // 2. Snapshot - Represents the state of the future (connectionState, data,error)
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop'),
      ),
      body: FutureBuilder(
          future: fetchProductbyId(widget.product_id),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // show loadind
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              // show error
              return Text('Error ${snapshot.error.toString()}');
            } else {
              // show our data.
              if (snapshot.hasData) {
                var data = snapshot.data;
                // Buid our UI
                return Stack(
                  children: [
                    ProductCard(product: data),
                    Positioned(
                        bottom: 0,
                        right: MediaQuery.of(context).size.width * .4,
                        child: ElevatedButton(
                            onPressed: () {
                              // ALerts , Modals
                              showModalBottomSheet(
                                  context: context,
                                  builder: (_) {
                                    return Container(
                                      height: MediaQuery.of(context).size.height*.5,
                                      child: Mpesa());
                                  });
                            },
                            child: Text('BUY')))
                  ],
                );

                // return ProductCard(product: data);
                // return Column(
                //   children: [
                //     ProductCard(product: data),
                //     // Image.network(
                //     //   '$baseurl/static/images/${data[5]}',
                //     //   scale: 2.5,
                //     // ),
                //     // Text(data[1]),
                //     // Text(NumberFormat().format(data[3])),
                //     // Text(data[2]),
                //     TextButton.icon(onPressed: () {}, label: const Text('Buy'))
                //   ],
                // );
              } else {
                return const Text('No Data');
              }
            }
          }),
    );
  }
}