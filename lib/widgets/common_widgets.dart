import 'package:flutter/material.dart';

import '../core/routes.dart';
import '../core/theme.dart';
import '../data/models.dart';
import '../data/repository.dart';
import '../state/app_state.dart';

/// Scrollable page with large title; leaves room for the floating nav.
class ScreenPage extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const ScreenPage({super.key, required this.title, required this.children});
  @override
  Widget build(BuildContext context) => SafeArea(
    bottom: false,
    child: ListView(
      padding: const EdgeInsets.fromLTRB(Sp.page, 16, Sp.page, 130),
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineLarge),
        const SizedBox(height: Sp.page),
        ...children,
      ],
    ),
  );
}

class PastelCard extends StatelessWidget {
  final Color color;
  final Widget child;
  final VoidCallback? onTap;
  final double? height;
  const PastelCard({
    super.key,
    required this.color,
    required this.child,
    this.onTap,
    this.height,
  });
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      height: height,
      padding: const EdgeInsets.all(Sp.gap),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(Sp.radius),
      ),
      child: child,
    ),
  );
}

class RoundIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const RoundIconButton(this.icon, this.onTap, {super.key});
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: 48,
      height: 48,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: C.ink),
    ),
  );
}

class PillButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const PillButton(this.label, this.onTap, {super.key});
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      height: 52,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: C.accent,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Text(label, style: Theme.of(context).textTheme.titleMedium),
    ),
  );
}

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;
  const SectionHeader(this.title, {super.key, this.onSeeAll});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        if (onSeeAll != null)
          GestureDetector(
            onTap: onSeeAll,
            child: Text(
              'See all',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
      ],
    ),
  );
}

class InfoPill extends StatelessWidget {
  final IconData icon;
  final String text;
  const InfoPill(this.icon, this.text, {super.key});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white54,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [Icon(icon, size: 16), const SizedBox(width: 6), Text(text)],
    ),
  );
}

/// Bottom sheet to pick a meal and log a recipe to the journal.
void pickMealSheet(BuildContext context, Recipe r) {
  showModalBottomSheet(
    context: context,
    builder: (_) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Text(
            'Add "${r.title}" to',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          for (final m in Repository.meals)
            ListTile(
              title: Text(m),
              trailing: const Icon(Icons.add_circle_outline),
              onTap: () {
                appState.addToJournal(m, r);
                Navigator.pop(context);
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Added to $m')));
              },
            ),
        ],
      ),
    ),
  );
}

class RecipeCard extends StatelessWidget {
  final Recipe r;
  const RecipeCard(this.r, {super.key});
  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: appState,
    builder: (_, __) => Padding(
      padding: const EdgeInsets.only(bottom: Sp.gap),
      child: PastelCard(
        color: r.color,
        height: 190,
        onTap: () => Navigator.pushNamed(context, Routes.recipe, arguments: r),
        child: Stack(
          children: [
            // Positioned(right: -10, bottom: 20, child: Text(r.emoji, style: const TextStyle(fontSize: 84))),
            Positioned(
              right: -10,
              bottom: 10,
              child: r.image.isEmpty
                  ? Text(r.emoji, style: const TextStyle(fontSize: 84))
                  : AppImage(r.image, height: 130),
            ),
            Positioned(
              left: 0,
              top: 0,
              child: RoundIconButton(
                appState.favorites.contains(r.id)
                    ? Icons.favorite
                    : Icons.favorite_border,
                () => appState.toggleFavorite(r.id),
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: RoundIconButton(
                Icons.add,
                () => pickMealSheet(context, r),
              ),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              right: 90,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(r.title, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  InfoPill(Icons.schedule, '${r.minutes} min'),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class AppImage extends StatelessWidget {
  final String path;
  final double? width, height;
  final BoxFit fit;
  const AppImage(
    this.path, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
  });

  Widget _error() => SizedBox(
    width: width,
    height: height,
    child: const Icon(Icons.broken_image_outlined, color: C.muted),
  );

  @override
  Widget build(BuildContext context) {
    if (path.startsWith('http')) {
      return Image.network(
        path,
        width: width,
        height: height,
        fit: fit,
        loadingBuilder: (_, child, progress) => progress == null
            ? child
            : SizedBox(
                width: width,
                height: height,
                child: const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
        // errorBuilder: (_, __, ___) => _error(),
        errorBuilder: (_, error, __) {
          debugPrint('NETWORK image error: $error');
          return _error();
        },
      );
    }
    return Image.asset(
      path,
      width: width,
      height: height,
      fit: fit,
      // errorBuilder: (_, __, ___) => _error(),
      errorBuilder: (_, error, __) {
        debugPrint('ASSET image error: $error');
        return _error();
      },
    );
  }
}
