import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../data/repository.dart';
import '../state/app_state.dart';
import '../widgets/common_widgets.dart';

class JournalScreen extends StatelessWidget {
  const JournalScreen({super.key});
  static const _colors = [C.lilac, C.yellow, C.mint, C.peach];

  @override
  Widget build(BuildContext context) => ListenableBuilder(
        listenable: appState,
        builder: (context, _) => ScreenPage(title: 'Journal', children: [
          Container(
            padding: const EdgeInsets.all(Sp.gap),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(Sp.radius)),
            child: Column(children: [
              Row(children: [
                const CircleAvatar(backgroundColor: C.chip, child: Icon(Icons.local_fire_department, color: C.orange)),
                const SizedBox(width: 12),
                Text('Calories', style: Theme.of(context).textTheme.titleMedium),
              ]),
              const SizedBox(height: 12),
              _stat('Consumed', '${appState.consumed} cal'),
              _stat('Remaining', '${appState.remaining} cal'),
              const SizedBox(height: 8),
              Row(children: [
                _macro('Power\nCarbs', appState.carbsNow, appState.carbsGoal),
                _macro('Protein\nPower', appState.proteinNow, appState.proteinGoal),
                _macro('Healthy\nFat', appState.fatNow, appState.fatGoal),
              ]),
            ]),
          ),
          const SizedBox(height: Sp.gap),
          GridView.count(
            crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 1.35,
            children: [for (var i = 0; i < Repository.meals.length; i++) _mealTile(context, Repository.meals[i], _colors[i])],
          ),
        ]),
      );

  Widget _stat(String l, String v) => Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(color: C.bg, borderRadius: BorderRadius.circular(16)),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(l), Text(v)]),
      );

  Widget _macro(String label, int now, int goal) => Expanded(
        child: Container(
          margin: const EdgeInsets.only(right: 8), padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: C.bg, borderRadius: BorderRadius.circular(20)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Expanded(child: Text('$now/$goal', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12))),
              SizedBox(width: 20, height: 20, child: CircularProgressIndicator(
                  value: (now / goal).clamp(0, 1).toDouble(), strokeWidth: 4, color: C.orange, backgroundColor: Colors.white)),
            ]),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontSize: 11, color: C.muted)),
          ]),
        ),
      );

  Widget _mealTile(BuildContext context, String meal, Color color) => PastelCard(
        color: color,
        onTap: () => _showMeal(context, meal),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('${appState.mealKcal(meal)} kcal', style: Theme.of(context).textTheme.titleMedium),
          Text('${appState.journal[meal]!.length} items', style: Theme.of(context).textTheme.bodySmall),
          const Spacer(),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(meal, style: Theme.of(context).textTheme.titleMedium),
            RoundIconButton(Icons.add, () => _picker(context, meal)),
          ]),
        ]),
      );

  void _showMeal(BuildContext context, String meal) => showModalBottomSheet(
        context: context,
        builder: (_) => ListenableBuilder(
          listenable: appState,
          builder: (_, __) => SafeArea(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              ListTile(title: Text(meal, style: Theme.of(context).textTheme.titleLarge)),
              if (appState.journal[meal]!.isEmpty) const ListTile(title: Text('Nothing logged yet')),
              for (final r in appState.journal[meal]!)
                ListTile(
                  title: Text(r.title), subtitle: Text('${r.kcal} kcal'),
                  trailing: IconButton(icon: const Icon(Icons.delete_outline), onPressed: () => appState.removeFromJournal(meal, r)),
                ),
            ]),
          ),
        ),
      );

  void _picker(BuildContext context, String meal) => showModalBottomSheet(
        context: context,
        builder: (_) => SafeArea(
          child: ListView(shrinkWrap: true, children: [
            for (final r in Repository.recipes)
              ListTile(
                title: Text(r.title), subtitle: Text('${r.kcal} kcal'),
                onTap: () { appState.addToJournal(meal, r); Navigator.pop(context); },
              ),
          ]),
        ),
      );
}
