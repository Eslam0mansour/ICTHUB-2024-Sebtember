import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:icthub_2024_9/features/home/data/data_models/product_data_model.dart';

// await prefs.setBool('repeat', true);
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
  /// save products to firebase [fireStore]
  static Future saveProductsToFirebase(Map<String, dynamic> data) async {
    await FirebaseFirestore.instance.collection('products').add(data);
  }
//!=============================================================================

  /// get products from firebase
 Future<List<ProductDataModel>> getProductsFormFirbase() async {
    QuerySnapshot<Map<String, dynamic>> getProducts =
        await FirebaseFirestore.instance.collection('products').get();
    getProducts.docs.forEach((element) {
     ProductDataModel model =  ProductDataModel.fromMap(element.data());
     productList.add(model);
    },);
    return productList;
  }
  

  
}
