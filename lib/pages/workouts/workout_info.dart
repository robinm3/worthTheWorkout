import 'package:flutter/material.dart';
import 'package:workout/pages/workouts/workout_play.dart';
import 'package:workout/shared/components/clickable_card.dart';
import 'package:workout/shared/layouts/double_color_layout.dart';
import '../../services/types/workout_types.dart';

class WorkoutInfoPage extends StatelessWidget {
  const WorkoutInfoPage({Key? key, required this.title, required this.workout})
      : super(key: key);

  final String title;
  final Workout workout;

  void onBackButtonPressed(BuildContext context) {
    Navigator.pop(context);
  }

  static const titleStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            color: Theme.of(context).highlightColor,
            onPressed: () => onBackButtonPressed(context),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: DoubleColorLayout(
          topColor: Theme.of(context).colorScheme.primary,
          topChild: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(title,
                style: Theme.of(context).primaryTextTheme.displaySmall),
          ),
          bottomChild: Column(
            children: [
              SizedBox(
                height: 120,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      for (final exercise in workout.exercices)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: ClickableCard(
                            width: 100,
                            height: 120,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(exercise.name),
                                SizedBox(
                                    width: 80,
                                    height: 80,
                                    child: Image.network(exercise.imageLink))
                              ],
                            ),
                            onTap: () {},
                          ),
                        ),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: FloatingActionButton.extended(
                  icon: const Icon(Icons.play_arrow),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WorkoutPlay(workout: workout),
                        ));
                  },
                  label: const Text("Start", style: TextStyle(fontSize: 20)),
                ),
              )
            ],
          ),
        ),
      );
}
