import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soko_garden/api/api.dart';
import 'package:soko_garden/controller/shared_preferences.dart';

import '../controller/products.dart';
import 'create_product.dart';
import 'single_product.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  void initState() {
    super.initState();
    getUsername();
  }

  String? name;
  Future getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString(PrefsNaming.username);
    setState(() {
      name = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Soko Garden"),
        actions: [
          IconButton.filled(
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: Text('SignOut $name ?'),
                        actions: [
                          TextButton(
                              onPressed: () async {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.remove(PrefsNaming.username);

                                SystemNavigator.pop();
                              },
                              child: const Text('Yes')),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel'))
                        ],
                      );
                    });

                // Logout
                //1 - clear shared preference

                // Navigate to
              },
              icon: const Icon(Icons.person_3)),
          Text(
            name ?? 'LOGIN',
            style: const TextStyle(fontSize: 20),
          ),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const Createproduct()));
              },
              icon: const Icon(Icons.edit_note)),
        ],
      ),
      body: FutureBuilder(
          future: getproducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              var data = snapshot.data;
              if (data == null) {
                return const Text('No Products Found');
              } else {
                var products = data;
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    List product = products[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => Oneproduct(
                                      product_id: product[0],
                                    )));
                      },
                      child: ProductCard(product: product),
                    );
                  },
                );
              }
            }
          }),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
  });

  final List product;

  @override
  Widget build(BuildContext context) {
    String imageUrl = '$baseurl/static/images/${product[5]}';
    return Card(
      elevation: 2.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Image.network(
              imageUrl,
              fit: BoxFit.contain,
              repeat: ImageRepeat.repeatX,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product[1],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              product[2],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '\$${product[3]}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.payment),
                  onPressed: () {
                    // initiatePayment(product[5]);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}