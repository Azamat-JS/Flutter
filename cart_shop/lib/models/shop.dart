import 'package:cart_shop/models/product.dart';
import 'package:flutter/material.dart';

class Shop extends ChangeNotifier {
  final List<Product> _shop = [
    Product(
      name: 'Product 1',
      price: 400,
      description: 'Item description',
      imagePath: 'assets/images/hoodie2.webp',
    ),
    Product(
      name: 'Product 2',
      price: 300,
      description: 'Item description',
      imagePath: 'assets/images/glasses.jpeg',
    ),
    Product(
      name: 'Product 3',
      price: 1000,
      description: 'Item description',
      imagePath: 'assets/images/watch.jpeg',
    ),
    Product(
      name: 'Product 4',
      price: 600,
      description: 'Item description',
      imagePath: 'assets/images/shoes.jpeg',
    ),
  ];

  List<Product> _cart = [];

  List<Product> get shop => _shop;

  List<Product> get cart => _cart;

  void addToCart(Product item) {
    _cart.add(item);
    notifyListeners();
  }

  void removeFromCart(Product item) {
    _cart.remove(item);
    notifyListeners();
  }
}
