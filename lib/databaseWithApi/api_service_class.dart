import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'model_class.dart';
class ApiServices {
  final String baseUrl = 'https://dummyjson.com/products';

  Future<List<dynamic>> getEshopApi() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<dynamic> productsJson = data['products'];
        return productsJson;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to fetch products: $e");
      throw Exception('Failed to fetch products: $e');
    }
  }
}