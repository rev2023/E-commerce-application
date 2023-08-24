import 'package:flutter/cupertino.dart';
import 'package:e_commerce_application/models/product.dart';

import '../db/cart_db.dart';

class CartProvider extends ChangeNotifier {

  CartDatabase cart = CartDatabase.instance;
  List<Product> productList = [];
  int quantity = 0;
  int size = 8;
  double totalCost = 0;

  Future getItemsInCart() async {
    productList = await cart.readAllEntries();
    getTotalCost();
    notifyListeners();
  }
  void getTotalCost() {
    double cost = 0;
    for (Product product in productList) {
      cost += double.parse(product.price.amount);
    }
    totalCost = cost;
  }
  void delete(Product product){
    cart.deleteEntry(int.parse(product.id));
    productList.remove(product);
    notifyListeners();
  }

}
