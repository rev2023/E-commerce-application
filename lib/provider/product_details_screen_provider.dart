import 'package:e_commerce_application/models/product.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreenProvider extends ChangeNotifier {
  late Product product;
  int _counterValue = 0;
  List<Widget> allSizes = [];
  List<bool> _selectedSize = <bool>[true, false, false, false];
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

  set setProduct(Product product) {
    this.product = product;
    notifyListeners(); // Notify listeners that the product has been set
  }

  Color parseColor(String colorName) {
    final Map<String, Color> colorMap = {
      'black': Colors.black,
      'white': Colors.white,
      'red': Colors.red,
      'pink': Colors.pink,
      'purple': Colors.purple,
      'deepPurple': Colors.deepPurple,
      'indigo': Colors.indigo,
      'blue': Colors.blue,
      'lightBlue': Colors.lightBlue,
      'cyan': Colors.cyan,
      'teal': Colors.teal,
      'green': Colors.green,
      'lightGreen': Colors.lightGreen,
      'lime': Colors.lime,
      'yellow': Colors.yellow,
      'amber': Colors.amber,
      'orange': Colors.orange,
      'deepOrange': Colors.deepOrange,
      'brown': Colors.brown,
      'grey': Colors.grey,
      'blueGrey': Colors.blueGrey,
    };

    return colorMap[colorName.toLowerCase()] ?? Colors.black; // Default to black if color is not found
  }


  // This method populates the 'sizes' list with the sizes from the product
  void populateSizes() {
    // Populate the sizes list
    for (String size in product.sizes) {
      allSizes.add(Text(
        size,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ));
    }
    // Notify listeners after the list is populated
    notifyListeners();
  }

}
