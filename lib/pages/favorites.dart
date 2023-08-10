import 'package:flutter/material.dart';

import '../shared/layouts/double_color_layout.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  FavoritesPageState createState() => FavoritesPageState();
}

class FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DoubleColorLayout(
        topColor: Theme.of(context).primaryColor,
        topChild: Text(
          'Favorites',
          style: Theme.of(context).primaryTextTheme.displaySmall,
        ),
        bottomChild: const Wrap(
          alignment: WrapAlignment.center,
          children: [Text("No favorites yet")],
        ),
      ),
    );
  }
}
