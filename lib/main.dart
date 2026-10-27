import 'package:flutter/material.dart';
import 'package:nutri_eats/screens/my_test_screen.dart';

import 'core/routes.dart';
import 'core/theme.dart';

void main() => runApp(const NutriEatsApp());

class NutriEatsApp extends StatelessWidget {
  const NutriEatsApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'NutriEats',
    debugShowCheckedModeBanner: false,
    theme: appTheme(),
    // initialRoute: Routes.home,
    // onGenerateRoute: Routes.generate,

    // abcd
    home: MyTestScreen(),
  );
}
