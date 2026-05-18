import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductService {
  static Future<List<Product>> getProducts() async {
    final response = await http.get(
      Uri.parse(
          "https://musiclibraryproject.onlinewebshop.net/htdocs/api/getProducts.php"),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data["status"] == "success") {
        List products = data["products"];
        return products.map((item) => Product.fromJson(item)).toList();
      }
    }
    throw Exception("Failed to load products: ${response.statusCode}");
  }

  static Future<bool> addProduct(Product product) async {
    final response = await http.post(
      Uri.parse(
          "https://musiclibraryproject.onlinewebshop.net/htdocs/api/addProduct.php"),
      body: {
        "title": product.title,
        "artist": product.artist,
        "url": product.youtubeUrl,
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["status"] == "success";
    }
    return false;
  }

  static Future<bool> updateProduct(Product product) async {
    final response = await http.post(
      Uri.parse(
          "https://musiclibraryproject.onlinewebshop.net/htdocs/api/updateProduct.php"),
      body: {
        "id": product.id.toString(),
        "title": product.title,
        "artist": product.artist,
        "url": product.youtubeUrl,
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["status"] == "success";
    }
    return false;
  }

  static Future<bool> deleteProduct(int id) async {
    final response = await http.post(
      Uri.parse(
          "https://musiclibraryproject.onlinewebshop.net/htdocs/api/deleteProduct.php"),
      body: {"id": id.toString()},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["status"] == "success";
    }
    return false;
  }
}
