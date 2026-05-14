import 'dart:convert';

import 'package:flutter_project/models/products_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<Product>> fetchProducts() async {
    final response = await http.get(
      Uri.parse("https://wantapi.com/products.php"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List list = data["data"];

      return list.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception("No product");
    }
  }
}
