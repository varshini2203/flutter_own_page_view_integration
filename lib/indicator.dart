import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  final bool isActive;

  const Indicator({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      margin: const EdgeInsets.symmetric(horizontal: 6),
      width: isActive ? 26 : 12,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.purpleAccent: Colors.grey.shade600,
        borderRadius: BorderRadius.circular(10),
        boxShadow: isActive
            ? [
          BoxShadow(
            color: Colors.purpleAccent.withOpacity(0.8),
            blurRadius: 12,
            spreadRadius: 2,
          ),
        ]
            : [],
      ),
    );
  }
}
