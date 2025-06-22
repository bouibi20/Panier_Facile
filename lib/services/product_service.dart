import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../models/product.dart';

class ProductService {
  static const String _baseUrl = 'https://dummyjson.com/products';

  // Récupérer tous les produits
  Future<List<Product>> getProducts() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> productsJson = data['products'];
        return productsJson.map((json) => Product.fromJson(json)).toList();
      } else {
        Get.snackbar(
          'Erreur',
          'Impossible de récupérer les produits. Code: ${response.statusCode}',
          snackPosition: SnackPosition.BOTTOM,
        );
        return [];
      }
    } catch (e) {
      Get.snackbar(
        'Erreur',
        'Une erreur est survenue: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
      return [];
    }
  }

  // Récupérer un produit par son ID
  Future<Product?> getProductById(int id) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/$id'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return Product.fromJson(data);
      } else {
        Get.snackbar(
          'Erreur',
          'Impossible de récupérer le produit. Code: ${response.statusCode}',
          snackPosition: SnackPosition.BOTTOM,
        );
        return null;
      }
    } catch (e) {
      Get.snackbar(
        'Erreur',
        'Une erreur est survenue: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    }
  }

  // Rechercher des produits
  Future<List<Product>> searchProducts(String query) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/search?q=$query'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> productsJson = data['products'];
        return productsJson.map((json) => Product.fromJson(json)).toList();
      } else {
        Get.snackbar(
          'Erreur',
          'Impossible de rechercher les produits. Code: ${response.statusCode}',
          snackPosition: SnackPosition.BOTTOM,
        );
        return [];
      }
    } catch (e) {
      Get.snackbar(
        'Erreur',
        'Une erreur est survenue: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
      return [];
    }
  }
}
