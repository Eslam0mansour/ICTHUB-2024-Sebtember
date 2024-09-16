import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:icthub_2024_9/features/home/data/data_models/product_data_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  bool isError = false;

  /// sdasdsa
  Future<void> getProductsData() async {
    try {
      isLoading = true;
      listOfProducts.clear();
      setState(() {});
      final uri = Uri.parse('https://fakestoreapi.com/products');

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        List<dynamic> listOfObjects = jsonDecode(response.body);

        for (Map<String, dynamic> map in listOfObjects) {
          ProductDataModel product = ProductDataModel(
            title: map['title'],
            price: map['price'].toDouble(),
            description: map['description'],
            image: map['image'],
          );
          listOfProducts.add(product);
        }
        isLoading = false;
        print(listOfProducts.length);
        setState(() {});
      } else {
        throw Exception('${response.statusCode}');
      }
    } catch (e) {
      print(e);
      print('Failed to fetch data');
    }
  }

  List<ProductDataModel> listOfProducts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: listOfProducts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.network(
                    listOfProducts[index].image ?? '',
                    width: 50,
                    height: 100,
                  ),
                  title: Text(
                    listOfProducts[index].title ?? 'No title',
                    maxLines: 1,
                  ),
                  subtitle: Text(
                    listOfProducts[index].description ?? 'No description',
                    maxLines: 2,
                  ),
                  trailing: Text('\$${listOfProducts[index].price ?? 0.0}'),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: isLoading ? null : getProductsData,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
