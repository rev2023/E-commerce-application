import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_application/provider/auth_provider.dart';
import 'package:e_commerce_application/router/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:e_commerce_application/styles/app_colors.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const CustomAppBar({required this.scaffoldKey, Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;

    return SliverAppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: AppColors.backgroundColor,
      leadingWidth: double.infinity,
      leading: SizedBox(
        height: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                scaffoldKey.currentState?.openDrawer();
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
                  child: GestureDetector(
                    onTap:(){ context.router.push(HomeRoute());},
                    child: SvgPicture.asset(
                      'lib/assets/images/logo.svg',
                    ),
                  ),
                ),
              ),
            ),
             Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(user!.displayName!) // You can use a default avatar image
              ),
              ),
          ],
        ),
      ),
      toolbarHeight: 110,
    );
  }
}
