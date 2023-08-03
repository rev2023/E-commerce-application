import 'package:e_commerce_application/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../styles/app_colors.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      drawer: const Drawer(),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: AppColors.backgroundColor,
              leadingWidth: double.infinity,
              leading: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 90,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () {
                              _scaffoldKey.currentState?.openDrawer();
                            },
                            icon: const Icon(
                              Icons.menu,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                height: 90,
                                width: 250,
                                child: SvgPicture.asset(
                                    'lib/assets/images/logo.svg'),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 16.0),
                            child: Icon(
                              Icons.person,
                              color: AppColors.primaryColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              toolbarHeight: 110,
            ),
          ];
        },
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: SizedBox(
                height: 90,
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
                          'Explore',
                          style: TextStyle(fontSize: 30),
                        )),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 25.0),
                    child: Center(
                      child: Text(
                        'Our Brands',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black87),
                            borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Center(
                              child: Text(
                                'All',
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: const BoxDecoration(
                            color: AppColors.nikeOrange,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                            SvgPicture.asset('lib/assets/images/nike.svg'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            color: AppColors.pumaRed,
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                                'lib/assets/images/puma-white.svg'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding( // Used to display products
                    padding: const EdgeInsets.all(26.0),
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      height: MediaQuery.of(context).size.height,
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
              icon: Icon(Icons.shopping_basket), label: 'Cart'),
        ],
      ),
    );
  }
}
