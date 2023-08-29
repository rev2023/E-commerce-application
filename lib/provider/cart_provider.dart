import 'package:flutter/cupertino.dart';
import 'package:e_commerce_application/models/product.dart';
import 'package:e_commerce_application/db/cart_db.dart';

class CartProvider extends ChangeNotifier {

  CartDatabase cart = CartDatabase.instance;
  List<Product> productList = [];
  int quantity = 0;
  int size = 8;
  double totalCost = 0;
  double vatAmount = 0;

  Future getItemsInCart() async {
    productList = await cart.readAllEntries();
    getTotalCost();
    notifyListeners();
  }
  void decrementQuantity(Product product){
    if(product.quantity! > 1){
      cart.decrementQuantity(product);
    }
  }
  void incrementQuantity(Product product){
      cart.incrementQuantity(product);
  }
  void getTotalCost() {
    double cost = 0;
    for (Product product in productList) {
      cost += double.parse(product.price.amount);
    }
    vatAmount = 0.03 * cost;
    totalCost = cost + vatAmount;
  }
  void delete(Product product){
    cart.deleteEntry(int.parse(product.id));
    productList.remove(product);
    notifyListeners();
  }
  void clearCart(){
    cart.deleteAllEntries();
    productList.clear();
    notifyListeners();
  }
}
