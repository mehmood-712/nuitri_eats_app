import 'package:flutter/material.dart';

class Recipe {
  final String id, title, emoji, image; // <-add image
  final int minutes, kcal, carbs, protein, fat;
  final Color color;
  final List<String> ingredients, steps;
  const Recipe(
    this.id,
    this.title,
    this.emoji,
    this.minutes,
    this.kcal,
    this.carbs,
    this.protein,
    this.fat,
    this.color,
    this.ingredients,
    this.steps, {
    this.image = '', // <- add this named param
  });
}

class Article {
  final String id, title, author, tag, body;
  final Color color;
  const Article(
    this.id,
    this.title,
    this.author,
    this.tag,
    this.color,
    this.body,
  );
}

class UserProfile {
  final int age;
  final double weightKg, heightCm;
  final String goal; // Lose, Maintain, Gain
  const UserProfile(this.age, this.weightKg, this.heightCm, this.goal);

  /// Mifflin-St Jeor (sex-neutral average) x light activity, adjusted by goal.
  int get dailyKcal {
    final bmr = 10 * weightKg + 6.25 * heightCm - 5 * age - 78;
    final adj = goal == 'Lose'
        ? -400
        : goal == 'Gain'
        ? 400
        : 0;
    return (bmr * 1.4 + adj).round();
  }
}
