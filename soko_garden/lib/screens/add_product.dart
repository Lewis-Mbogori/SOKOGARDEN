import 'package:flutter/material.dart';

class Createproduct extends StatefulWidget {
  const Createproduct({super.key});

  @override
  State<Createproduct> createState() => _CreateproductState();
}

class _CreateproductState extends State<Createproduct> {
List toselect = ['Smartphones', 'Appliances', 'Electronics','Bedding','Clothes'];

late String? selected = toselect[0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Product"),
      ),
      body: Column(
        children: [
          Form(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Product Name",
                      prefixIcon: Icon(Icons.description),
                    ),
                    keyboardType: TextInputType.text,
                  validator: (value){
                    if(value!.isEmpty || int.tryParse(value) != null){
                      return 'Enter a valid name';
                    }
                    else{
                      return null;
                    }
                  },
                  ),    
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Product Price",
                      prefixIcon: Icon(Icons.money),
                    ),
                    keyboardType: TextInputType.number,
                  validator: (value){
                    if(value!.isEmpty || double.tryParse(value) == null){
                      return 'Enter a valid number';
                    }
                    else{
                      return null;
                    }
                  },
                  ),


                  
                ),


                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DropdownButtonFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    value: selected,
                    items: List.generate(toselect.length, 
                    (index){
                      return DropdownMenuItem(
                        value: toselect[index],
                        child: Text(toselect[index]));

                    }), 
                    onChanged: (value){
                      setState(() {
                        selected = value.toString();
                      });
                    })
   
                ),

              


              ],
            ))
        ],
      )
    );
  }
}