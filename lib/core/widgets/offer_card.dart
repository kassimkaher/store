import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:store_web/config/store_app.dart';
import 'package:store_web/core/widgets/custom_cached_image.dart';

class OfferCard extends StatelessWidget {
  final String title;
  final String badge;
  final String imageUrl;
  final Color backgroundColor;

  final VoidCallback? onTap;

  const OfferCard({
    super.key,
    required this.title,
    required this.badge,
    required this.imageUrl,
    required this.backgroundColor,

    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width * 0.8,
        height: 180,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Stack(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PhosphorIcon(
                          PhosphorIcons.gift(PhosphorIconsStyle.duotone),
                          size: 32,
                          color: colorScheme.onTertiary,
                        ),

                        OfferTitle(
                          backgroundColor: backgroundColor,
                          title: title,
                          textTheme: textTheme,
                        ),
                        FilledButton(
                          onPressed: () {},
                          child: Text(
                            "عرض",
                            style: textTheme.bodyLarge?.copyWith(
                              color: colorScheme.onPrimaryContainer,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Expanded(
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        bottomLeft: Radius.circular(24),
                      ),
                      gradient: LinearGradient(
                        colors: [
                          colorScheme.primaryContainer.withAlpha(100),
                          colorScheme.tertiaryContainer,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(24),
                        topLeft: Radius.circular(24),
                      ),
                      child: CustomCachedImage(
                        imageUrl: imageUrl,

                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Positioned(
            //   top: 12,
            //   bottom: 0,
            //   right: 0,
            //   left: 150,

            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     spacing: 4,
            //     children: [
            //       OfferTitle(
            //         backgroundColor: backgroundColor,
            //         title: title,
            //         textTheme: textTheme,
            //       ),
            //       FilledButton(
            //         onPressed: () {},
            //         child: Text(
            //           "عرض",
            //           style: textTheme.bodyLarge?.copyWith(
            //             color: colorScheme.onPrimaryContainer,
            //             fontWeight: FontWeight.w900,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class OfferTitle extends StatelessWidget {
  const OfferTitle({
    super.key,
    required this.backgroundColor,
    required this.title,
    required this.textTheme,
  });

  final Color backgroundColor;
  final String title;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,

      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(24),
          bottomLeft: Radius.circular(24),
          topLeft: Radius.circular(24),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            // width: double.infinity,
            decoration: BoxDecoration(
              color: backgroundColor.withAlpha(100),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(24),
                bottomLeft: Radius.circular(24),
                topLeft: Radius.circular(24),
              ),
            ),
            child: Text(
              title,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ),
      ),
    );
  }
}
