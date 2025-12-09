import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:store_web/config/store_app.dart';
import 'package:store_web/core/utils/functions/price.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/widgets/custom_cached_image.dart';
import '../../../auth/cubit/auth_cubit.dart';
import '../../../bookmarks/presentation/cubit/bookmark_cubit.dart';
import '../../../bookmarks/presentation/cubit/bookmark_state.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';
import '../../domain/entities/product_entity.dart';
import '../cubit/product_detail_cubit.dart';
import '../cubit/product_detail_state.dart';

class ProductDetailPage extends StatefulWidget {
  final String productId;

  const ProductDetailPage({super.key, required this.productId});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final storeId = getIt<AuthCubit>().currentAuthData?.storeId ?? '';

    return BlocProvider(
      create: (context) => ProductDetailCubit(
        getProductDetailsUseCase: getIt(),
        storeId: storeId,
      )..loadProductDetails(widget.productId),
      child: Scaffold(
        body: BlocBuilder<ProductDetailCubit, ProductDetailState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox.shrink(),
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (product) => Stack(
                children: [
                  Column(
                    children: [
                      _buildHeader(context, product),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.only(bottom: 200),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildImageSection(product),
                              const SizedBox(height: 24),
                              _buildProductInfo(product),
                              const SizedBox(height: 16),
                              _buildDescription(product),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: _buildBottomBar(context, product),
                  ),
                ],
              ),
              error: (message) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 48,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      message,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ProductDetailCubit>().loadProductDetails(
                          widget.productId,
                        );
                      },
                      child: const Text('إعادة المحاولة'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ProductEntity product) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 48, 24, 16),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/');
              }
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Color(0xFFEFF0EF),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Color(0xFF4A5250),
                size: 24,
              ),
            ),
          ),
          Row(
            children: [
              BlocBuilder<BookmarkCubit, BookmarkState>(
                builder: (context, state) {
                  final isBookmarked = context
                      .read<BookmarkCubit>()
                      .isBookmarked(product.id);
                  return GestureDetector(
                    onTap: () {
                      context.read<BookmarkCubit>().toggleBookmark(product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            isBookmarked
                                ? 'تمت إزالة ${product.name} من المحفوظات'
                                : 'تمت إضافة ${product.name} إلى المحفوظات',
                          ),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Color(0xFFEFF0EF),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isBookmarked ? Icons.favorite : Icons.favorite_border,
                        color: const Color(0xFF4A5250),
                        size: 24,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(width: 12),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImageSection(ProductEntity product) {
    final mainImage = (product.baseUrl ?? "") + (product.image ?? '');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          // Main Image
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: CustomCachedImage(
                  imageUrl: mainImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductInfo(ProductEntity product) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4A5250),
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.description ?? '',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF8A9290),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              _buildRateUi(),
            ],
          ),
          const SizedBox(height: 16),

          Text(
            '${formatPrice(product.price)} د.ع',
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color(0xFF005292),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildRateUi() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF0EF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Icon(Icons.star, size: 16, color: Color(0xFFFFA500)),
          const SizedBox(width: 4),
          const Text(
            '4.8',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4A5250),
            ),
          ),
          const SizedBox(width: 4),
          const Text(
            '(124)',
            style: TextStyle(fontSize: 12, color: Color(0xFF8A9290)),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription(ProductEntity product) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('الوصف', style: textTheme.titleMedium),
          const SizedBox(height: 12),
          Text(
            product.description ?? ' لا يوجد وصف متاح لهذا المنتج.',
            style: textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context, ProductEntity product) {
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        border: const Border(
          top: BorderSide(color: Color(0xFFE5E8E6), width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('الكمية', style: textTheme.titleMedium),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (_quantity > 1) {
                          setState(() => _quantity--);
                        }
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Color(0xFFEFF0EF),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.remove,
                          color: Color(0xFF4A5250),
                          size: 20,
                        ),
                      ),
                    ),
                    Container(
                      width: 50,
                      alignment: Alignment.center,
                      child: Text(
                        '$_quantity',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4A5250),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setState(() => _quantity++),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Color(0xFFEFF0EF),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Color(0xFF4A5250),
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                context.read<CartCubit>().addToCart(
                  product,
                  quantity: _quantity,
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'تمت إضافة $_quantity من ${product.name} إلى السلة',
                    ),
                    duration: const Duration(seconds: 2),
                    backgroundColor: const Color(0xFF005292),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFF005292),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF005292).withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_cart, color: Colors.white, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Add to Cart',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
