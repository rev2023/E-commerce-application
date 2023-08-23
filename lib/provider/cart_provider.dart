import 'package:flutter/cupertino.dart';
import 'package:e_commerce_application/models/product.dart';

import '../db/cart_db.dart';

class CartProvider extends ChangeNotifier {

  CartDatabase cart = CartDatabase.instance;
  List<Product> productList = [];

  Future getItemsInCart() async {
    productList = await cart.readAllEntries();
    notifyListeners();
  }
  void delete(Product product){
    productList.remove(product);
    cart.deleteEntry(product.brandName);
  }
  notifyListeners();
}
