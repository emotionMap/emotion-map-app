import 'package:emotion_map_app/style/index.dart';
import 'package:flutter/material.dart';

class DaysChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const DaysChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? AppColors.accent : AppColors.background,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          label,
          style: NotoSansKR.semiBold.set(
            size: 12,
            color: selected ? Colors.white : AppColors.textMuted,
          ),
        ),
      ),
    );
  }
}
