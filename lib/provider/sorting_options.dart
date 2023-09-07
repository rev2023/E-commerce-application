
enum SortingOption {
  regular,
  sortAscendingAlphabetically,
  sortDescendingAlphabetically,
  sortPriceDescending,
  sortPriceAscending,
}

extension SortingOptionExtensions on SortingOption {
  String toDisplayString() {
    switch (this) {
      case SortingOption.regular:
        return 'Regular';
      case SortingOption.sortAscendingAlphabetically:
        return 'Sort A - Z';
      case SortingOption.sortDescendingAlphabetically:
        return 'Sort Z - A';
      case SortingOption.sortPriceDescending:
        return 'Highest to Lowest price';
      case SortingOption.sortPriceAscending:
        return 'Lowest to Highest price';
      default:
        return 'Regular';
    }
  }
}



