import 'package:auto_route/auto_route.dart';
import 'package:currency_symbols/currency_symbols.dart';
import 'package:e_commerce_application/provider/product_details_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:counter_button/counter_button.dart';
import 'package:e_commerce_application/styles/app_colors.dart';

@RoutePage()
@RoutePage()
class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productDetailsProvider =
        Provider.of<ProductDetailsScreenProvider>(context);
    if (productDetailsProvider.allSizes.isEmpty) {
      productDetailsProvider.populateSizes();
    }
    return Scaffold(
      drawer: const Drawer(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.router.pop();
                    },
                    child: const Center(
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.person,
                    color: AppColors.primaryColor,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    height: 400,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.backgroundColor,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.grey.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            width: double.infinity,
                            child: Image.network(
                              productDetailsProvider.product.mainImage,
                              width: 300,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                                'SKU: ${productDetailsProvider.product.SKU}'),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Row(
                              children: [
                                const Text('Colour: '),
                                Container(
                                  height: 10,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      color: productDetailsProvider.parseColor(
                                          productDetailsProvider.product.color),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(50))),
                                )
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              'Stock Status: ${productDetailsProvider.product.stockStatus}',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, top: 20, bottom: 5),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              productDetailsProvider.product.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Row(
                            children: [
                              Text(
                                cSymbol(productDetailsProvider
                                    .product.price.currency),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(width: 3),
                              Text(
                                productDetailsProvider.product.price.amount,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.black87,
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(60),
                                  bottomRight: Radius.circular(60))),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 20.0, left: 20),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Description:',
                              style:
                                  TextStyle(fontSize: 17, color: Colors.white),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 20),
                          child: Text(
                            productDetailsProvider.product.description,
                            style: const TextStyle(
                                fontSize: 15, color: Colors.white60),
                          ),
                        ),
                        const SizedBox(height: 30),
                        const SizedBox(
                            child: Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Available Sizes',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              )),
                        )),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, left: 20),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.black, width: 1),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0)),
                              ),
                              child: ToggleButtons(
                                selectedColor: Colors.white,
                                borderColor: Colors.black87,
                                direction: Axis.horizontal,
                                onPressed: (int index) {
                                  List<bool> newSelectedSize = List.generate(
                                      productDetailsProvider.allSizes.length,
                                      (i) => i == index);
                                  productDetailsProvider.selectedSize =
                                      newSelectedSize;
                                },
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                                selectedBorderColor: Colors.black,
                                constraints: const BoxConstraints(
                                  minHeight: 40.0,
                                  minWidth: 80.0,
                                ),
                                isSelected: productDetailsProvider.selectedSize,
                                children: productDetailsProvider.allSizes,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 20),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              height: 50,
                              child: CounterButton(
                                loading: false,
                                onChange: (int val) {
                                  if (val <= 15) {
                                    productDetailsProvider.counterValue = val;
                                  }
                                },
                                count: productDetailsProvider.counterValue,
                                countColor: Colors.black54,
                                buttonColor: Colors.black54,
                                progressColor: Colors.black54,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: SizedBox(
                              height: 40,
                              width: 120,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10), // Adjust the value as needed
                                  ),
                                  backgroundColor: Colors.green,
                                  // Add other styling properties here
                                ),
                                child: const Text(
                                  'Add to cart',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black87,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            label: 'Cart',
          ),
        ],
      ),
    );
  }
}
