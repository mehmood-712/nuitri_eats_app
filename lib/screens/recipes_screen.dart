import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../data/repository.dart';
import '../state/app_state.dart';
import '../widgets/common_widgets.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({super.key});
  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  String _q = '';
  bool _favOnly = false;
  @override
  Widget build(BuildContext context) => ListenableBuilder(
        listenable: appState,
        builder: (context, _) {
          var list = Repository.search(_q);
          if (_favOnly) list = list.where((r) => appState.favorites.contains(r.id)).toList();
          return ScreenPage(title: 'Recipes', children: [
            TextField(
              onChanged: (v) => setState(() => _q = v),
              decoration: InputDecoration(
                  hintText: 'Search recipes', prefixIcon: const Icon(Icons.search),
                  filled: true, fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none)),
            ),
            const SizedBox(height: 12),
            Wrap(spacing: 8, children: [
              ChoiceChip(label: const Text('All'), selected: !_favOnly, onSelected: (_) => setState(() => _favOnly = false)),
              ChoiceChip(label: const Text('Favorites'), selected: _favOnly, onSelected: (_) => setState(() => _favOnly = true)),
            ]),
            const SizedBox(height: Sp.gap),
            for (final r in list) RecipeCard(r),
          ]);
        },
      );
}
