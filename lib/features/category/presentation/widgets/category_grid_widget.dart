import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:store_web/config/store_app.dart';
import 'package:store_web/core/widgets/custom_cached_image.dart';

import '../../domain/entities/category_entity.dart';

class CategoryGridWidget extends StatelessWidget {
  final List<CategoryEntity> categories;
  final String storeId;

  const CategoryGridWidget({
    super.key,
    required this.categories,
    required this.storeId,
  });

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(24.0),
        child: Center(child: Text('No categories available')),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('الاقسام', style: textTheme.titleLarge),
          const SizedBox(height: 16),
          SizedBox(
            height: 120,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.all(0),
              child: Row(
                children: categories
                    .map(
                      (cat) => _CategoryCard(category: cat, storeId: storeId),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final CategoryEntity category;
  final String storeId;

  const _CategoryCard({required this.category, required this.storeId});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push("/category/${category.id}/${category.name}/$storeId");
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => CategoryProductsPage(
        //       categoryId: category.id,
        //       categoryName: category.name,
        //       storeId: storeId,
        //     ),
        //   ),
        // );
      },
      borderRadius: BorderRadius.circular(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: colorScheme.outline, width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: category.image != null
                  ? Padding(
                      padding: const EdgeInsets.all(12),
                      child: CustomCachedImage(
                        imageUrl: '${category.contentUrl}${category.image!}',
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(
                      color: Colors.grey[200],
                      child: Icon(
                        Icons.category,
                        size: 40,
                        color: Colors.grey[400],
                      ),
                    ),
            ),
          ),

          // Category Name
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: Text(
              category.name,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // Item Count Badge
          if (category.itemCount != null && category.itemCount! > 0)
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${category.itemCount} items',
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
