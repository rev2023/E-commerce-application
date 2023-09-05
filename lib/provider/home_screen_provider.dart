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
    for (int j = 1; j < productList.length; j++) {
      double key = double.parse(productList[j].price.amount);
      Product temp = productList[j];
      int i = j - 1;
      productList.asMap().forEach((index, product) {
        if (index >= 0 && double.parse(product.price.amount) < key) {
          productList[index + 1] = productList[index];
          i = index;
        }
      });
      productList[i + 1] = temp;
    }

    notifyListeners();
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
