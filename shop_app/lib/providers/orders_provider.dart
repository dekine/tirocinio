import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import './cart_provider.dart';

class OrderItem {
  OrderItem({
    Key? key,
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });

  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  final String? authToken;
  final String? userId;

  Orders(this.authToken, this.userId, this._orders);

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final url = Uri.parse(
        'https://shop-app-77a56-default-rtdb.europe-west1.firebasedatabase.app/orders/$userId.json?auth=$authToken');
    final res = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    late Map<String, dynamic> extractedData;
    if (res.body.isNotEmpty) {
      extractedData = json.decode(res.body) as Map<String, dynamic>;
    }

    extractedData.forEach((orderId, orderData) {
      if (orderData != '') {
        loadedOrders.add(
          OrderItem(
            id: orderId,
            amount: orderData['amount'],
            dateTime: DateTime.parse(orderData['dateTime']),
            products: (orderData['products'] as List<dynamic>)
                .map(
                  (item) => CartItem(
                    id: item['id'],
                    price: item['price'],
                    quantity: item['quantity'],
                    title: item['title'],
                  ),
                )
                .toList(),
          ),
        );
      }
    });

    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = Uri.parse(
        'https://shop-app-77a56-default-rtdb.europe-west1.firebasedatabase.app/orders/$userId.json?auth=$authToken');
    final timestamp = DateTime.now();
    final res = await http.post(
      url,
      body: json.encode({
        'amount': total,
        'dateTime': timestamp.toIso8601String(),
        'products': cartProducts
            .map((cp) => {
                  'id': cp.id,
                  'title': cp.title,
                  'quantity': cp.quantity,
                  'price': cp.price,
                })
            .toList(),
      }),
    );
    _orders.insert(
      0,
      OrderItem(
        id: json.decode(res.body)['name'],
        amount: total,
        dateTime: DateTime.now(),
        products: cartProducts,
      ),
    );
    notifyListeners();
  }
}
