import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../data/models.dart';

class ArticleDetailScreen extends StatelessWidget {
  final Article a;
  const ArticleDetailScreen(this.a, {super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: a.color,
        appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
        body: ListView(padding: const EdgeInsets.all(Sp.page), children: [
          Text(a.title, style: Theme.of(context).textTheme.headlineLarge),
          const SizedBox(height: 8),
          Text('${a.author} · ${a.tag}', style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: Sp.page),
          Text(a.body, style: const TextStyle(fontSize: 16, height: 1.6)),
        ]),
      );
}
