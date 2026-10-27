import 'package:flutter/material.dart';
import '../data/models.dart';
import '../screens/article_detail_screen.dart';
import '../screens/home_shell.dart';
import '../screens/profile_form_screen.dart';
import '../screens/recipe_detail_screen.dart';

class Routes {
  static const home = '/', profile = '/profile', recipe = '/recipe', article = '/article';

  static Route<dynamic> generate(RouteSettings s) {
    final Widget page = switch (s.name) {
      profile => const ProfileFormScreen(),
      recipe => RecipeDetailScreen(s.arguments as Recipe),
      article => ArticleDetailScreen(s.arguments as Article),
      _ => const HomeShell(),
    };
    return MaterialPageRoute(builder: (_) => page, settings: s);
  }
}
