import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lec16_shop/providers/auth.dart';

import 'package:lec16_shop/models/http_exception.dart';
import 'package:lec16_shop/providers/product.dart';

class Products with ChangeNotifier {
  static const baseUrl = 'lecture16-d5ccd-default-rtdb.firebaseio.com';
  List<Product> _items = [];
  String? authToken;
  String? userId;

  Products(this.authToken, this.userId, this._items);

  List<Product>? get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<List<Product>?> fetchAndSetProducts(
      {bool filterByUser = false}) async {
    final filterString = filterByUser
        ? {'orderBy': 'ownerId', 'equalTo': userId, 'auth': authToken}
        : {'auth': authToken};

    final url = Uri.https(baseUrl, '/products.json', filterString);

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final urlFav =
          Uri.https(baseUrl, '/userFav/$userId.json', {'auth': authToken});

      //url = '$baseUrl/userFav/$userId.json?auth=$authToken';
      final favoriteResponse = await http.get(urlFav);
      final favoriteData = json.decode(favoriteResponse.body);
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          isFavorite:
              favoriteData == null ? false : favoriteData[prodId] ?? false,
          imageUrl: prodData['imageUrl'],
        ));
      });
      _items = loadedProducts;
      notifyListeners();
      return _items;
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addProduct(Product product) async {
    //final url = '$baseUrl/products.json?auth=$authToken';
    final url = Uri.https(baseUrl, '/products.json', {'auth': authToken});

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'ownerId': userId,
          //'isFavorite': product.isFavorite,
        }),
      );
      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
      // _items.insert(0, newProduct); // at the start of the list
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(String? id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      //final url = Uri.https('baseUrl', '/products/$id.json?auth=$authToken');
      final url = Uri.https(baseUrl, '/products/$id.json', {'auth': authToken});

      //final url = '$baseUrl/products/$id.json?auth=$authToken';
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteProduct(String id) async {
    //final url = '$baseUrl/$id.json?auth=$authToken';
    //final url = Uri.https('baseUrl', '/$id.json?auth=$authToken');
    print('Products-> deleteProduct, Id: $id');
    final url = Uri.https(baseUrl, '/products/$id.json', {'auth': authToken});

    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    print('after removeAt: $url');
    notifyListeners();
    final response = await http.delete(url);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingProduct.dispose();
  }

  void receiveToken(Auth auth, List<Product> items) {
    authToken = auth.token;
    userId = auth.userId;
    print('Products receiveToken, userId: $userId');
    _items = items;
  }
}
