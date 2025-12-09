import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:store_web/core/utils/functions/price.dart';
import 'package:store_web/core/widgets/custom_cached_image.dart';
import 'package:store_web/features/products/domain/entities/product_entity.dart';

import '../../features/bookmarks/presentation/cubit/bookmark_cubit.dart';
import '../../features/bookmarks/presentation/cubit/bookmark_state.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity productData;

  final VoidCallback? onLikeTap;
  final VoidCallback? onAddToCart;

  const ProductCard({
    super.key,
    required this.productData,

    this.onLikeTap,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return GestureDetector(
      onTap: () {
        context.go('/product/${productData.id}');
      },
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: colorScheme.outline.withAlpha(100),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section with badges
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: colorScheme.surfaceContainerHighest.withOpacity(
                        0.3,
                      ),
                    ),
                    margin: const EdgeInsets.all(12),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CustomCachedImage(
                        imageUrl: "${productData.baseUrl}${productData.image}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Bookmark button
                  Positioned(
                    top: 20,
                    right: 20,
                    child: BlocBuilder<BookmarkCubit, BookmarkState>(
                      builder: (context, state) {
                        final isBookmarked = context
                            .read<BookmarkCubit>()
                            .isBookmarked(productData.id);
                        return GestureDetector(
                          onTap: () {
                            context.read<BookmarkCubit>().toggleBookmark(
                              productData,
                            );
                            final message = isBookmarked
                                ? 'تمت إزالة ${productData.name} من المحفوظات'
                                : 'تمت إضافة ${productData.name} إلى المحفوظات';
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(message),
                                duration: const Duration(seconds: 2),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isBookmarked
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                              size: 20,
                              color: isBookmarked
                                  ? Colors.blue
                                  : colorScheme.onSurfaceVariant,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // New badge
                ],
              ),
            ),
            // Product info
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productData.name,
                    style: textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    productData.description ?? "",
                    style: textTheme.labelSmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${formatPrice(productData.price)} د.ع',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.primary,
                        ),
                      ),
                      GestureDetector(
                        onTap: onAddToCart,
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: colorScheme.secondary,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.add_shopping_cart,
                            size: 16,
                            color: colorScheme.onSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
