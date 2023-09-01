import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class AppDrawer extends StatelessWidget {
  final VoidCallback onDrawerItemOnePressed;
  final VoidCallback onDrawerItemTwoPressed;

  const AppDrawer({
    Key? key,
    required this.onDrawerItemOnePressed,
    required this.onDrawerItemTwoPressed,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [

              Container(
                width: 5,
                child: ListTile(
                  title: Text(AppLocalizations.of(context)!.explore),
                  trailing: const Icon(Icons.arrow_right_alt),
                  onTap: () {
                    onDrawerItemOnePressed();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  width: 5,
                  child: ListTile(
                    title:  Text(AppLocalizations.of(context)!.preferences),
                    trailing: const Icon(Icons.arrow_right_alt),
                    onTap: () {
                      onDrawerItemTwoPressed();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
