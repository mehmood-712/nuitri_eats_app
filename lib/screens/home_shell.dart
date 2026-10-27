import 'package:flutter/material.dart';
import '../state/app_state.dart';
import '../widgets/floating_nav.dart';
import 'assistant_screen.dart';
import 'journal_screen.dart';
import 'learning_screen.dart';
import 'meal_plan_screen.dart';
import 'recipes_screen.dart';

class HomeShell extends StatelessWidget {
  const HomeShell({super.key});
  static const _pages = [RecipesScreen(), MealPlanScreen(), AssistantScreen(), JournalScreen(), LearningScreen()];

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<int>(
        valueListenable: tabIndex,
        builder: (_, i, __) => Scaffold(
          body: Stack(children: [
            IndexedStack(index: i, children: _pages),
            Positioned(left: 16, right: 16, bottom: 24, child: FloatingNav(index: i, onTap: (v) => tabIndex.value = v)),
          ]),
        ),
      );
}
