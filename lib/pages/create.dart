import 'package:flutter/material.dart';
import 'package:workout/pages/creation/exercice_creation.dart';
import 'package:workout/pages/creation/workout_creation.dart';
import 'package:workout/shared/layouts/double_color_layout.dart';

import '../shared/components/clickable_card.dart';

const pages = [
  {'label': 'Workout', 'icon': '🏃'},
  {'label': 'Exercice', 'icon': '🏋️'},
];

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  void _onPageSelected(String page) async {
    if (page == 'Workout') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => WorkoutCreation()));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ExerciceCreation()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DoubleColorLayout(
        topColor: Theme.of(context).colorScheme.primary,
        topChild: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Let\'s create!',
              style: Theme.of(context).primaryTextTheme.displaySmall,
            ),
            Text(
              'A workout or an exercice?',
              style: Theme.of(context).primaryTextTheme.headlineSmall,
            ),
          ],
        ),
        bottomChild: Wrap(
          alignment: WrapAlignment.center,
          children: [
            for (final page in pages)
              Padding(
                padding: const EdgeInsets.all(20),
                child: ClickableCard(
                  onTap: () => _onPageSelected(page['label']!),
                  width: 100,
                  height: 120,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(page['icon']!,
                          style:
                              Theme.of(context).primaryTextTheme.displayMedium),
                      Text(page['label']!),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
