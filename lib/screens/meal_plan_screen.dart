import 'package:flutter/material.dart';
import '../core/routes.dart';
import '../core/theme.dart';
import '../data/repository.dart';
import '../state/app_state.dart';
import '../widgets/common_widgets.dart';

class MealPlanScreen extends StatelessWidget {
  const MealPlanScreen({super.key});
  @override
  Widget build(BuildContext context) => ListenableBuilder(
        listenable: appState,
        builder: (context, _) => ScreenPage(title: 'Meal Plan 🔥', children: [
          PastelCard(
            color: C.yellow,
            child: appState.profile == null
                ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Personalise Meal Plan', style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 8),
                    Text('To personalize your menu, we still need information.', style: Theme.of(context).textTheme.bodySmall),
                    const SizedBox(height: Sp.gap),
                    SizedBox(width: 200, child: PillButton('Fill in Data', () => Navigator.pushNamed(context, Routes.profile))),
                  ])
                : Text('Your daily goal: ${appState.target} kcal', style: Theme.of(context).textTheme.titleMedium),
          ),
          SectionHeader('Lunch or Dinner', onSeeAll: () => tabIndex.value = 0),
          for (final r in Repository.recipes.take(3)) RecipeCard(r),
        ]),
      );
}
