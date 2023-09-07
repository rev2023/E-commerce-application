import 'package:e_commerce_application/models/product.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreenProvider extends ChangeNotifier {

  final Product product;
  int _counterValue = 0;
  List<String> allSizes = [];
  List<bool> _selectedSize = <bool>[true, false, false, false];

  ProductDetailsScreenProvider(this.product);

  get selectedSize => _selectedSize;
  set selectedSize(selectedSize){
    _selectedSize = selectedSize;
    notifyListeners();
  }

  int get counterValue => _counterValue;
  set counterValue(int count){
      _counterValue = count;
    notifyListeners();
  }

  // This method populates the 'sizes' list with the sizes from the product
  void populateSizes() {
    // Populate the sizes list
    for (String size in product.sizes) {
      allSizes.add(size);
    }
    // Notify listeners after the list is populated
    notifyListeners();
  }
}
