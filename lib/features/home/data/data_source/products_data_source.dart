import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:icthub_2024_9/features/home/data/data_models/product_data_model.dart';

class ProductsDataSource {
  /// get products from firebase [FirebaseFirestore]
  Future<List<ProductDataModel>> getProductsFormFirebase() async {
    List<ProductDataModel> productList = [];

    QuerySnapshot<Map<String, dynamic>> getProducts =
        await FirebaseFirestore.instance.collection('products').get();
    for (var element in getProducts.docs) {
      ProductDataModel model = ProductDataModel.fromMap(element.data());
      productList.add(model);
    }
    return productList;
  }

  /// get products from fakestoreapi.com
  Future<List<ProductDataModel>> getProductsFakeStoreApi() async {
    try {
      List<ProductDataModel> listOfProducts = [];
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
        return listOfProducts;
      } else {
        throw Exception('${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
