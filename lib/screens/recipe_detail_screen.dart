import 'package:flutter/material.dart';

import '../core/theme.dart';
import '../data/models.dart';
import '../widgets/common_widgets.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe r;
  const RecipeDetailScreen(this.r, {super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: r.color,
    appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
    body: ListView(
      padding: const EdgeInsets.all(Sp.page),
      children: [
        // Center(child: Text(r.emoji, style: const TextStyle(fontSize: 110))),
        Center(
          child: r.image.isEmpty
              ? Text(r.emoji, style: const TextStyle(fontSize: 110))
              : AppImage(r.image, height: 200),
        ),
        Text(r.title, style: Theme.of(context).textTheme.headlineLarge),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            InfoPill(Icons.schedule, '${r.minutes} min'),
            InfoPill(Icons.local_fire_department, '${r.kcal} kcal'),
            InfoPill(Icons.grain, 'C ${r.carbs}g'),
            InfoPill(Icons.egg_alt, 'P ${r.protein}g'),
            InfoPill(Icons.water_drop, 'F ${r.fat}g'),
          ],
        ),
        const SectionHeader('Ingredients'),
        for (final i in r.ingredients) Text('• $i'),
        const SectionHeader('Steps'),
        for (var n = 0; n < r.steps.length; n++)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text('${n + 1}. ${r.steps[n]}'),
          ),
        const SizedBox(height: Sp.page),
        PillButton('Add to Journal', () => pickMealSheet(context, r)),
      ],
    ),
  );
}
