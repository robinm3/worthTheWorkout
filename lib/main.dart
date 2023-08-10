import 'package:flutter/material.dart';
import 'package:workout/pages/community.dart';
import 'package:workout/pages/favorites.dart';
import 'package:workout/pages/profile.dart';
import 'pages/create.dart';
import 'pages/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Worth the workout',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 115, 98, 212)),
        useMaterial3: true,
      ),
      home: DefaultTabController(
          length: 5,
          child: Scaffold(
            body: TabBarView(
              children: [
                MyHomePage(),
                const FavoritesPage(),
                const CreatePage(),
                const CommunityPage(),
                const ProfilePage(),
              ],
            ),
            bottomNavigationBar: const TabBar(
              indicator: BoxDecoration(),
              tabs: [
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.star)),
                Tab(icon: Icon(Icons.add_circle, size: 40)),
                Tab(icon: Icon(Icons.people)),
                Tab(icon: Icon(Icons.person)),
              ],
            ),
          )),
    );
  }
}
