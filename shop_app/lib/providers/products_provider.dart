import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';
import './product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get favoriteItems =>
      _items.where((item) => item.isFavorite).toList();

  List<Product> get items => [..._items];

  Product findById(String id) => _items.firstWhere((e) => e.id == id);

  bool containsById(String id) {
    for (var item in _items) {
      if (item.id == id) return true;
    }
    return false;
  }

  Future<void> fetchAndSetProducts() async {
    final url = Uri.https(
        'shop-app-77a56-default-rtdb.europe-west1.firebasedatabase.app',
        '/products.json');

    try {
      final res = await http.get(url);
      final extractedData = json.decode(res.body) as Map<String, dynamic>;
      final List<Product> loadedData = [];
      extractedData.forEach((productId, productData) {
        loadedData.add(Product(
            id: productId,
            title: productData['title'],
            description: productData['description'],
            price: productData['price'],
            imageUrl: productData['imageUrl'],
            isFavorite: productData['isFavorite']));
      });
      _items = loadedData;
      notifyListeners();
    } catch (err) {
      rethrow;
    }
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.https(
        'shop-app-77a56-default-rtdb.europe-west1.firebasedatabase.app',
        '/products.json');
    try {
      final res = await http.post(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
            'isFavorite': product.isFavorite,
          }));
      final newProduct = Product(
        id: json.decode(res.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url = Uri.https(
          'shop-app-77a56-default-rtdb.europe-west1.firebasedatabase.app',
          '/products/$id.json');
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'price': newProduct.price,
            'imageUrl': newProduct.imageUrl,
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = Uri.https(
        'shop-app-77a56-default-rtdb.europe-west1.firebasedatabase.app',
        '/products/$id.json');
    final existingProductIndex = _items.indexWhere((prod) => id == prod.id);
    final existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    // http.delete(url).catchError((_) {
    //   _items.insert(existingProductIndex, existingProduct);
    //   notifyListeners();
    // });
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
  }
}
