import 'package:flutter/material.dart';
import 'package:nayapakistan/common_widget/round_button.dart';
import 'package:nayapakistan/view/Plan_view/plan_view.dart';
import 'package:nayapakistan/view/meal_planner/meal_planner_view.dart';
import 'package:nayapakistan/view/sleep_tracker/sleep_tracker_view.dart';
import 'package:nayapakistan/view/workout_tracker/workout_tracker_view.dart';

class SelectView extends StatelessWidget {
  const SelectView({super.key});

  @override
  Widget build(BuildContext context) {
    // var media = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoundButton(
                title: "Workout Tracker",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WorkoutTrackerView(),
                    ),
                  );
                }),
            const SizedBox(
              height: 15,
            ),
            RoundButton(
                title: "Meal Planner",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MealPlannerView(),
                    ),
                  );
                }),
            const SizedBox(
              height: 15,
            ),
            RoundButton(
                title: "Make your plan",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PlanView()));
                }),
            const SizedBox(height: 15),
            RoundButton(
                title: "Sleep Tracker",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SleepTrackerView(),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
