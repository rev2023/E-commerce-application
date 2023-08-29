class ProductPrice {
  final String amount;
  final String currency;

  ProductPrice({
    required this.amount,
    required this.currency,
  });

  factory ProductPrice.fromJson(Map<String, dynamic> json) {
    return ProductPrice(
      amount: json['amount'] as String,
      currency: json['currency'] as String,
    );
  }
}