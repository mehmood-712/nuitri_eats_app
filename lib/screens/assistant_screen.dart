import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../data/repository.dart';
import '../state/app_state.dart';
import '../widgets/common_widgets.dart';

/// Smart picks driven by remaining calories (local logic).
class AssistantScreen extends StatelessWidget {
  const AssistantScreen({super.key});
  @override
  Widget build(BuildContext context) => ListenableBuilder(
        listenable: appState,
        builder: (context, _) {
          final picks = Repository.suggest(appState.remaining);
          return ScreenPage(title: 'Smart Picks ✨', children: [
            PastelCard(
              color: C.lilac,
              child: Text('You have ${appState.remaining} kcal left today. Here are meals that fit.',
                  style: Theme.of(context).textTheme.titleMedium),
            ),
            const SizedBox(height: Sp.gap),
            if (picks.isEmpty) const Text('Daily goal reached. Nice work!'),
            for (final r in picks) RecipeCard(r),
          ]);
        },
      );
}
