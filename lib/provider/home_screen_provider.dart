import 'package:e_commerce_application/provider/sorting_options.dart';
import 'package:e_commerce_application/repository/product_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_application/models/product.dart';
import 'package:e_commerce_application/services/services_configuration.dart';

class HomeScreenProvider extends ChangeNotifier {
  final ProductRepository productRepository = getIt<ProductRepository>();
  List<Product> productList = [];
  SortingOption _selectedOption = SortingOption.regular;

  HomeScreenProvider();

  SortingOption get selectedSortingOption => _selectedOption;

  set selectedSortingOption(SortingOption option) {
    _selectedOption = option ;
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
      case SortingOption.sortAscendingAlphabetically:
        sortAscendingAlphabetically();
        notifyListeners();
        break;
      case SortingOption.sortDescendingAlphabetically:
        sortDescendingAlphabetically();
        notifyListeners();
        break;
      case SortingOption.sortPriceDescending:
        sortPriceDescending();
        notifyListeners();
        break;
      case SortingOption.sortPriceAscending:
        sortPriceAscending();
        notifyListeners();
        break;
      case SortingOption.sortAscendingAlphabetically:
        sortAscendingAlphabetically();
        notifyListeners();
        break;
      case SortingOption.sortDescendingAlphabetically:
        sortDescendingAlphabetically();
        notifyListeners();
        break;
      case SortingOption.sortPriceDescending:
        sortPriceDescending();
        notifyListeners();
        break;
      case SortingOption.regular:
        fetchData();
        notifyListeners();
        break;
      default:
        throw Exception('Error selecting option');
        break;
    }
  }

  void sortPriceDescending() {
    productList.sort((productOne, productTwo) =>
        double.parse(productTwo.price.amount).compareTo(double.parse(productOne.price.amount)));
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
