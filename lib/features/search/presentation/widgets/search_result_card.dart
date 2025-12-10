import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/search_result_entity.dart';

class SearchResultCard extends StatelessWidget {
  final SearchResultEntity result;
  final String storeId;

  const SearchResultCard({
    super.key,
    required this.result,
    required this.storeId,
  });

  String _formatPrice(double price) {
    final formatter = NumberFormat('#,###');
    return formatter.format(price.round());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          // Navigate to detail page based on type
          // TODO: Implement navigation to product/offer detail page
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Open ${result.type.name}: ${result.title}'),
              duration: const Duration(seconds: 1),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: result.image != null
                    ? Image.network(
                        result.image!,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return _buildPlaceholder();
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return _buildPlaceholder();
                        },
                      )
                    : _buildPlaceholder(),
              ),

              const SizedBox(width: 12),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Type Badge
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: result.type == SearchResultType.product
                                ? Colors.blue.withOpacity(0.1)
                                : Colors.orange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            result.type == SearchResultType.product
                                ? 'PRODUCT'
                                : 'OFFER',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: result.type == SearchResultType.product
                                  ? Colors.blue[700]
                                  : Colors.orange[700],
                            ),
                          ),
                        ),
                        if (result.categoryName != null) ...[
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              result.categoryName!,
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[600],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ],
                    ),

                    const SizedBox(height: 6),

                    // Title
                    Text(
                      result.title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    if (result.description != null &&
                        result.description!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        result.description!,
                        style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],

                    if (result.price != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        '${_formatPrice(result.price!)} د.ع',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              // Action Button
              IconButton(
                icon: Icon(
                  result.type == SearchResultType.product
                      ? Icons.add_shopping_cart
                      : Icons.arrow_forward_ios,
                  size: 20,
                ),
                color: Colors.blue,
                onPressed: () {
                  // Handle action based on type
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        result.type == SearchResultType.product
                            ? 'Add to cart: ${result.title}'
                            : 'View offer: ${result.title}',
                      ),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      width: 80,
      height: 80,
      color: Colors.grey[200],
      child: Icon(
        result.type == SearchResultType.product
            ? Icons.shopping_bag
            : Icons.local_offer,
        size: 40,
        color: Colors.grey[400],
      ),
    );
  }
}
