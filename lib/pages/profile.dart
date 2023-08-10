import 'package:flutter/material.dart';

import '../shared/layouts/double_color_layout.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DoubleColorLayout(
        topColor: Theme.of(context).primaryColor,
        topChild: Text(
          'Profile',
          style: Theme.of(context).primaryTextTheme.displaySmall,
        ),
        bottomChild: const Wrap(
          alignment: WrapAlignment.center,
          children: [Text("No profile yet")],
        ),
      ),
    );
  }
}
