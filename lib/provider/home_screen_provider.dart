import 'package:e_commerce_application/repository/product_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_application/models/product.dart';

class HomeScreenProvider extends ChangeNotifier {
  ProductRepository productRepository = ProductRepository();
  List<Product> productList = [];

  HomeScreenProvider() {
    // Call fetchData method inside the constructor
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      ProductList products = await productRepository.fetchData();
      productList = products.productList;
      notifyListeners(); // Notify listeners that the data has been fetched
    } catch (e) {
      // Handle any errors that might occur during data fetching
      print('Error fetching data: $e');
    }
  }

  void filterNike() async {
    await fetchData();
    productList.removeWhere((product) => product.brandName != 'Nike');
    notifyListeners();
  }

  void filterPuma() async {
    await fetchData();
    productList.removeWhere((product) => product.brandName != 'Puma');
    notifyListeners();
  }
}
