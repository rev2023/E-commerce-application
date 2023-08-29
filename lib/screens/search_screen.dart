import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_application/provider/search_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce_application/styles/app_colors.dart';
import 'package:e_commerce_application/widgets/custom_app_bar.dart';
import 'package:e_commerce_application/widgets/product_holder.dart';
import 'package:e_commerce_application/widgets/search_bar.dart';
import 'package:e_commerce_application/provider/product_details_screen_provider.dart';
import 'package:e_commerce_application/router/app_router.gr.dart';

@RoutePage()
class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>(); // Create GlobalKey here

    return Scaffold(
      drawer: const Drawer(),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            CustomAppBar(scaffoldKey: _scaffoldKey),
          ];
        },
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: SizedBox(
                height: 92,
                child: SearchBar(),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 22.0),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Your Results: ',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Consumer<SearchScreenProvider>(
                    builder: (context, searchScreenProvider, _) {
                      if (searchScreenProvider.productList.isEmpty && searchScreenProvider.noResult == false) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 100.0),
                            child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        );
                      } else if (searchScreenProvider.noResult) {
                        return const Center(child: Padding(
                          padding: EdgeInsets.all(60.0),
                          child: Text('No results'),
                        ));
                      } else {
                        return Padding(
                          padding: const EdgeInsets.only(top: 45.0),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio: 0.75,
                            ),
                            itemCount: searchScreenProvider.productList.length,
                            itemBuilder: (context, index) {
                              final product =
                              searchScreenProvider.productList[index];
                              return Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: GestureDetector(
                                    onTap: () {
                                      final productDetailsProvider = Provider
                                          .of<ProductDetailsScreenProvider>(
                                          context,
                                          listen: false);
                                      productDetailsProvider.product = product;
                                      context.router.push(ProductDetailsRoute());
                                    },
                                    child: ProductHolder(product: product)),
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
