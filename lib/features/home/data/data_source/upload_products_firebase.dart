import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:icthub_2024_9/features/home/data/data_models/product_data_model.dart';

/// this class is responsible for uploading products to firebase
/// [FirebaseFirestore] from the fakestoreapi.com
/// Used one time to upload products to firebase

class UploadProductsFirebase {
//!==================================parameters===========================================
  List<ProductDataModel> productList = [];

//!==================================functions===========================================
  static Future<void> uploadProducts() async {
    var url = Uri.parse('https://fakestoreapi.com/products');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> myProducts = jsonDecode(response.body);
      for (var items in myProducts) {
        saveProductsToFirebase(items);
      }
    }
  }

//!=============================================================================
  /// save products to firebase [FirebaseFirestore]
  static Future saveProductsToFirebase(Map<String, dynamic> data) async {
    await FirebaseFirestore.instance.collection('products').add(data);
  }
}
