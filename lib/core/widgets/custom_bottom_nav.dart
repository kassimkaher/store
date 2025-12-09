import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

enum BottomNavItem { home, saved, orders, caret }

class CustomBottomNav extends StatelessWidget {
  final BottomNavItem currentItem;
  final ValueChanged<BottomNavItem> onItemSelected;

  const CustomBottomNav({
    super.key,
    required this.currentItem,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(color: colorScheme.surface.withAlpha(20)),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _NavItem(
                    icon: PhosphorIcons.house(PhosphorIconsStyle.duotone),
                    label: ' الرئيسية',
                    isActive: currentItem == BottomNavItem.home,
                    onTap: () => onItemSelected(BottomNavItem.home),
                    colorScheme: colorScheme,
                    textTheme: textTheme,
                  ),
                  _NavItem(
                    icon: PhosphorIcons.bookBookmark(
                      PhosphorIconsStyle.duotone,
                    ),
                    label: 'المحفوظة',
                    isActive: currentItem == BottomNavItem.saved,
                    onTap: () => onItemSelected(BottomNavItem.saved),
                    colorScheme: colorScheme,
                    textTheme: textTheme,
                  ),

                  // Center floating search button
                  _NavItem(
                    icon: PhosphorIcons.bag(PhosphorIconsStyle.duotone),
                    label: 'الطلبات',
                    isActive: currentItem == BottomNavItem.orders,
                    onTap: () => onItemSelected(BottomNavItem.orders),
                    colorScheme: colorScheme,
                    textTheme: textTheme,
                  ),
                  _NavItem(
                    icon: PhosphorIcons.shoppingCart(
                      PhosphorIconsStyle.duotone,
                    ),
                    label: 'السلة',
                    isActive: currentItem == BottomNavItem.caret,
                    onTap: () => onItemSelected(BottomNavItem.caret),
                    colorScheme: colorScheme,
                    textTheme: textTheme,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
    required this.colorScheme,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PhosphorIcon(
            icon,
            size: 24,
            color: isActive
                ? colorScheme.primary
                : colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: textTheme.labelMedium?.copyWith(
              color: isActive
                  ? colorScheme.primary
                  : colorScheme.onSurfaceVariant,
              fontWeight: isActive ? FontWeight.w900 : FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
