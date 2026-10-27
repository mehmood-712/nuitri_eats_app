import 'package:flutter/foundation.dart';
import '../data/models.dart';
import '../data/repository.dart';

class AppState extends ChangeNotifier {
  UserProfile? profile;
  final favorites = <String>{};
  final journal = {for (final m in Repository.meals) m: <Recipe>[]};

  int get target => profile?.dailyKcal ?? 2000;
  Iterable<Recipe> get _all => journal.values.expand((e) => e);
  int get consumed => _all.fold(0, (s, r) => s + r.kcal);
  int get remaining => (target - consumed).clamp(0, 99999);
  int mealKcal(String m) => journal[m]!.fold(0, (s, r) => s + r.kcal);

  // Macro goals: 50% carbs, 25% protein, 25% fat (grams).
  int get carbsGoal => (target * .5 / 4).round();
  int get proteinGoal => (target * .25 / 4).round();
  int get fatGoal => (target * .25 / 9).round();
  int get carbsNow => _all.fold(0, (s, r) => s + r.carbs);
  int get proteinNow => _all.fold(0, (s, r) => s + r.protein);
  int get fatNow => _all.fold(0, (s, r) => s + r.fat);

  void saveProfile(UserProfile p) { profile = p; notifyListeners(); }
  void toggleFavorite(String id) {
    favorites.contains(id) ? favorites.remove(id) : favorites.add(id);
    notifyListeners();
  }
  void addToJournal(String meal, Recipe r) { journal[meal]!.add(r); notifyListeners(); }
  void removeFromJournal(String meal, Recipe r) { journal[meal]!.remove(r); notifyListeners(); }
}

final appState = AppState();

/// Bottom-nav tab index, shared so any screen can switch tabs.
final tabIndex = ValueNotifier<int>(1);
