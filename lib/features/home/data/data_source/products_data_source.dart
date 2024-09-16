import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:icthub_2024_9/features/home/data/data_models/product_data_model.dart';

class ProductsDataSource {
  static bool isLoading = false;
  static bool isError = false;
  static List<ProductDataModel> listOfProducts = [];

  static Future<bool> getProductsData() async {
    try {
      isLoading = true;
      isError = false;
      listOfProducts.clear();
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
      } else {
        throw Exception('${response.statusCode}');
      }
    } catch (e) {
      isError = true;
      isLoading = false;
      print(e);
      print('Failed to fetch data');
    }
    return false;
  }
}
