import 'package:flutter/material.dart';

import '../shared/layouts/double_color_layout.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  CommunityPageState createState() => CommunityPageState();
}

class CommunityPageState extends State<CommunityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DoubleColorLayout(
        topColor: Theme.of(context).primaryColor,
        topChild: Text(
          'Community',
          style: Theme.of(context).primaryTextTheme.displaySmall,
        ),
        bottomChild: const Wrap(
          alignment: WrapAlignment.center,
          children: [Text("No community yet")],
        ),
      ),
    );
  }
}
