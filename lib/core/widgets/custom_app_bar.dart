import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:store_web/core/services/storage_service.dart';
import 'package:store_web/utils/injector/injector.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String location;
  final String address;
  final VoidCallback? onLocationTap;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onCartTap;
  final bool hasNotification;

  const CustomAppBar({
    super.key,
    required this.location,
    required this.address,
    this.onLocationTap,
    this.onNotificationTap,
    this.onCartTap,
    this.hasNotification = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            location,
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Flexible(
                child: Text(
                  address,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        // Notification button

        // Cart button
        const SizedBox(width: 8),
        Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: PhosphorIcon(
              PhosphorIconsDuotone.house,
              size: 25,
              color: colorScheme.onPrimaryContainer,
            ),
            onPressed: () {
              getIt<MiniAppStorageService>().saveData("logout", "true");
            },
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
