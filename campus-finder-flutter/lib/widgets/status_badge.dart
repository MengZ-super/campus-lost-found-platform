import 'package:flutter/material.dart';
import '../utils/constants.dart';

class StatusBadge extends StatelessWidget {
  final String status;
  final double fontSize;

  const StatusBadge({super.key, required this.status, this.fontSize = 12});

  Color _backgroundColor(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return switch (status) {
      'pending' => cs.secondaryContainer,
      'claimed' => cs.primaryContainer,
      'closed' => cs.surfaceContainerHighest,
      _ => cs.surfaceContainerHighest,
    };
  }

  Color _foregroundColor(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return switch (status) {
      'pending' => cs.onSecondaryContainer,
      'claimed' => cs.onPrimaryContainer,
      'closed' => cs.onSurfaceVariant,
      _ => cs.onSurfaceVariant,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: _backgroundColor(context),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        statusLabels[status] ?? status,
        style: TextStyle(
          color: _foregroundColor(context),
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
