import 'package:flutter/material.dart';

import '../core/routes.dart';
import '../core/theme.dart';
import '../data/repository.dart';
import '../widgets/common_widgets.dart';

class LearningScreen extends StatefulWidget {
  const LearningScreen({super.key});
  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  String _tag = 'All';
  @override
  Widget build(BuildContext context) {
    final list = Repository.articles
        .where((a) => _tag == 'All' || a.tag == _tag)
        .toList();
    return ScreenPage(
      title: 'Learning',
      children: [
        SizedBox(
          height: 48,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              for (final t in ['All', ...Repository.tags])
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: () => setState(() => _tag = t),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: t == _tag ? C.ink : Colors.white,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Text(
                        t,
                        style: TextStyle(
                          color: t == _tag ? Colors.white : C.ink,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: Sp.gap),
        for (final a in list)
          Padding(
            padding: const EdgeInsets.only(bottom: Sp.gap),
            child: PastelCard(
              color: a.color,
              height: 150,
              onTap: () =>
                  Navigator.pushNamed(context, Routes.article, arguments: a),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          a.title,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                a.author,
                                style: Theme.of(context).textTheme.bodySmall,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(Icons.verified, size: 14),
                          ],
                        ),
                      ],
                    ),
                  ),
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: Colors.white54,
                    child: Text(
                      a.author[0],
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  /* a.avatar.isEmpty
    ? CircleAvatar(radius: 36, backgroundColor: Colors.white54,
        child: Text(a.author[0], style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w700)))
    : ClipOval(child: AppImage(a.avatar, width: 72, height: 72, fit: BoxFit.cover)), */
                ],
              ),
            ),
          ),
      ],
    );
  }
}
