import 'package:e_commerce_application/repository/product_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_application/models/product.dart';
import 'package:e_commerce_application/services/services_configuration.dart';

class HomeScreenProvider extends ChangeNotifier {
  final ProductRepository productRepository = getIt<ProductRepository>();
  List<Product> productList = [];
  String _selectedOption = 'Regular';

  HomeScreenProvider();

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
    productList.forEach((product) {
      double key = double.parse(product.price.amount);
      int i = productList.indexOf(product) - 1;

      while (i >= 0 && double.parse(productList[i].price.amount) < key) {
        productList[i + 1] = productList[i];
        i = i - 1;
      }

      productList[i + 1] = product;
      notifyListeners();
    });
  }

  void sortPriceAscending() {
    productList.sort((productOne, productTwo) =>
        double.parse(productOne.price.amount).compareTo(double.parse(productTwo.price.amount)));
    notifyListeners();
  }

  void sortAscendingAlphabetically() {
    productList.sort((productOne, productTwo) => productOne.name.compareTo(productTwo.name));
    notifyListeners();
  }

  void sortDescendingAlphabetically() {
    productList.sort((productOne, productTwo) => productTwo.name.compareTo(productOne.name));
    notifyListeners();
  }
}
