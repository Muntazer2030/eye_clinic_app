

import 'package:flutter/material.dart';

class NavTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isActive;
  final bool isCompact; // New parameter
  final VoidCallback onTap;
  const NavTile({
    super.key,
    required this.icon,
    required this.title,
    required this.isActive,
    required this.isCompact,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // If sidebar is collapsed (compact), show a centered icon only
    if (isCompact) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: IconButton(
          
          onPressed: onTap,
          icon: Icon(
            icon,
            color: isActive
                ? Theme.of(context).colorScheme.primary
                : Colors.grey[500],
          ),
          tooltip: title, // Show text on hover
        ),
      );
    }

    // Normal full width tile
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: isActive
          ? BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            )
          : null,
      child: ListTile(
        leading: Icon(
          icon,
          color: isActive
              ? Theme.of(context).colorScheme.primary
              : Colors.grey[500],
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isActive
                ? Theme.of(context).colorScheme.primary
                : Colors.grey[600],
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
