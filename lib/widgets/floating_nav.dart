import 'dart:ui';
import 'package:flutter/material.dart';
import '../core/theme.dart';

class FloatingNav extends StatelessWidget {
  final int index;
  final ValueChanged<int> onTap;
  const FloatingNav({super.key, required this.index, required this.onTap});
  static const icons = [Icons.soup_kitchen, Icons.event_available, Icons.auto_awesome, Icons.assignment, Icons.menu_book];

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            height: 72,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            color: const Color(0xFF8A9A80).withOpacity(.6),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              for (var i = 0; i < icons.length; i++)
                GestureDetector(
                  onTap: () => onTap(i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 56, height: 56,
                    decoration: BoxDecoration(color: i == index ? Colors.white : Colors.transparent, shape: BoxShape.circle),
                    child: Icon(icons[i], color: i == index ? C.ink : Colors.white70),
                  ),
                ),
            ]),
          ),
        ),
      );
}
