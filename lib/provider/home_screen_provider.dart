import 'package:e_commerce_application/repository/product_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_application/models/product.dart';
import 'package:e_commerce_application/services/services_configuration.dart';

class HomeScreenProvider extends ChangeNotifier {
  final ProductRepository productRepository = getIt<ProductRepository>();
  List<Product> productList = [];
  String _selectedOption = 'Regular';

  HomeScreenProvider() {
  }

  String get selectedSortingOption => _selectedOption;
  set selectedSortingOption(String option) {
    _selectedOption = option;
    notifyListeners();
  }

  Future<void> fetchData() async {
    try {
      ProductList products = await productRepository.fetchData();
      productList = products.productList;
      notifyListeners();
    } catch (e) {
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

  void handleSortingOption(newValue) {
    switch (newValue) {
      case 'Sort A - Z':
        sortAscendingAlphabetically();
        notifyListeners();
        break;
      case 'Sort Z - A':
        sortDescendingAlphabetically();
        notifyListeners();
        break;
      case 'Highest to Lowest price':
        sortPriceDescending();
        notifyListeners();
        break;
      case 'Lowest to Highest price':
        sortPriceAscending();
        notifyListeners();
        break;
      default:
        fetchData();
    }
  }

  void sortPriceDescending() {
    for (int j = 1; j < productList.length; j++) {
      double key = double.parse(productList[j].price['amount']);
      Product temp = productList[j];
      int i = j - 1;

      while (i >= 0 && double.parse(productList[i].price['amount']) < key) {
        productList[i + 1] = productList[i];
        i = i - 1;
      }
      productList[i + 1] = temp;
    }
    notifyListeners();
  }

  void sortPriceAscending() {
    productList.sort((a, b) =>
        double.parse(a.price['amount']).compareTo(double.parse(b.price['amount'])));
    notifyListeners();
  }

  void sortAscendingAlphabetically() {
    productList.sort((a, b) => a.name.compareTo(b.name));
    notifyListeners();
  }

  void sortDescendingAlphabetically() {
    productList.sort((a, b) => b.name.compareTo(a.name));
    notifyListeners();
  }
}
