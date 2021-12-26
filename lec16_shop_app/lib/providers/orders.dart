import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:lec16_shop/providers/auth.dart';
import 'package:lec16_shop/models/order_item.dart';
import 'package:lec16_shop/models/cart_item.dart';

class Orders with ChangeNotifier {
  static const baseUrl = 'lecture16-d5ccd-default-rtdb.firebaseio.com';
  List<OrderItem> _orders = [];
  String? authToken;
  String? userId;
  Orders(this.authToken, this.userId, this._orders);

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final url = Uri.https(baseUrl, '/orders/$userId.json', {'auth': authToken});

    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;

    extractedData.forEach((orderId, orderData) {
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
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    //final url = '$baseUrl/orders/$userId.json?auth=$authToken';
    //final url = Uri.https('baseUrl', '/orders/$userId.json?auth=$authToken');
    final url = Uri.https(baseUrl, '/orders/$userId.json', {'auth': authToken});
    final timestamp = DateTime.now();
    final response = await http.post(
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
        id: json.decode(response.body)['name'],
        amount: total,
        dateTime: timestamp,
        products: cartProducts,
      ),
    );
    notifyListeners();
  }

  void receiveToken(Auth auth, List<OrderItem> orders) {
    authToken = auth.token;
    userId = auth.userId;
    print('Orders receiveToken, userId: $userId');
    _orders = orders;
  }
}
