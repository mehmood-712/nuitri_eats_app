import 'package:flutter/material.dart';

import '../core/theme.dart';
import 'models.dart';

/// Local stand-in for a backend. Swap with an API client later.
class Repository {
  static const meals = ['Breakfast', 'Lunch', 'Dinner', 'Snack'];
  static const tags = ['Nutrition', 'Sustainability', 'Fitness'];

  static const recipes = <Recipe>[
    Recipe(
      'r1',
      'Gnocchi a la Sorrentina',
      '🍝🤣',
      20,
      520,
      68,
      18,
      20,
      C.lime,
      ['300g gnocchi', '200g tomato sauce', '100g mozzarella', 'Basil'],
      [
        'Boil gnocchi until they float.',
        'Toss with sauce.',
        'Top with mozzarella, bake 5 min.',
      ],
      // image: 'assets/images/gnocchi.png',
      // image: 'https://mattmoran.com.au/wp-content/uploads/2025/02/MM-ST-08_9152-Gnocchi-Low-res.jpg',
      image: 'https://images.unsplash.com/photo-1598449526978-cd11daa040c9?q=80&w=869&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=NHwxMjA3fDA%3D',
    ),
    Recipe(
      'r2',
      'Chicken Salad Lettuce Wraps',
      '🥗',
      30,
      360,
      18,
      38,
      14,
      C.mint,
      ['2 chicken breasts', 'Lettuce leaves', 'Cucumber', 'Cherry tomatoes'],
      [
        'Grill the chicken.',
        'Slice and mix with veg.',
        'Spoon into lettuce leaves.',
      ],
      image: 'assets/images/chicken_salad_lettuce_wraps.jpg',
    ),
    Recipe(
      'r3',
      'Veggie Power Bowl',
      '🥙',
      25,
      480,
      62,
      16,
      18,
      C.lilac,
      ['Quinoa', 'Chickpeas', 'Avocado', 'Kale'],
      ['Cook quinoa.', 'Roast chickpeas.', 'Assemble the bowl.'],
      image: 'assets/images/veggie_power_bowl.jpg',
    ),
    Recipe(
      'r4',
      'Shrimp Rice Plate',
      '🍤',
      35,
      359,
      44,
      28,
      8,
      C.peach,
      ['Shrimp', 'Rice', 'Garlic', 'Lemon'],
      ['Sear shrimp with garlic.', 'Serve on rice with lemon.'],
      image: 'assets/images/shrimp_rice_plate.jpg',
    ),
    Recipe(
      'r5',
      'Eggs & Avocado Toast',
      '🍳',
      10,
      631,
      55,
      26,
      34,
      C.yellow,
      ['2 eggs', 'Sourdough', 'Avocado'],
      ['Fry eggs.', 'Toast bread.', 'Stack and season.'],
      image: 'assets/images/eggs_avocado_toast.jpg',
    ),
    Recipe(
      'r6',
      'Greek Yogurt Berry Cup',
      '🍓',
      5,
      193,
      22,
      14,
      5,
      C.lilac,
      ['Greek yogurt', 'Berries', 'Honey'],
      ['Layer yogurt and berries.', 'Drizzle honey.'],
      image: 'assets/images/greek_yogurt_berry_cup.jpg',
    ),
  ];

  static const articles = <Article>[
    Article(
      'a1',
      'Nutrition Without Obsession',
      'Nutritionisthenewblack',
      'Nutrition',
      C.lilac,
      'Build habits, not rules. Focus on variety, protein at each meal and listening to hunger cues.',
    ),
    Article(
      'a2',
      'Tricks for Citrus Peels',
      'TooGoodToGo',
      'Sustainability',
      Colors.white,
      'Zest, candy or dry citrus peels to cut food waste and add flavor to teas and bakes.',
    ),
    Article(
      'a3',
      'The Recipe for a Balanced Life',
      'ekilu Team',
      'Nutrition',
      C.yellow,
      'Balance is a weekly average. Plan flexible meals and keep go-to staples ready.',
    ),
    Article(
      'a4',
      'Stick to your New Year\'s Resolutions',
      'Amy Coach',
      'Fitness',
      C.mint,
      'Start tiny, track weekly and attach new habits to existing routines.',
    ),
    Article(
      'a5',
      'Benefits of Walking',
      'Move Daily',
      'Fitness',
      C.peach,
      'A daily 30-minute walk supports heart health, mood and digestion.',
    ),
  ];

  /// Smart picks: recipes that fit the remaining calories, biggest fit first.
  static List<Recipe> suggest(int remainingKcal) =>
      (recipes.where((r) => r.kcal <= remainingKcal).toList()
        ..sort((a, b) => b.kcal.compareTo(a.kcal)));

  static List<Recipe> search(String q) => recipes
      .where((r) => r.title.toLowerCase().contains(q.toLowerCase()))
      .toList();
}
