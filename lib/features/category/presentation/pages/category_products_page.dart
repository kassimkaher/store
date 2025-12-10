import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_web/config/store_app.dart';
import 'package:store_web/core/widgets/product_card.dart';

import '../../../../utils/injector/injector.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';
import '../../../products/presentation/cubit/products_cubit.dart';
import '../../../products/presentation/cubit/products_state.dart';
import '../../domain/entities/category_entity.dart';
import '../cubit/categories_cubit.dart';
import '../cubit/categories_state.dart';

class CategoryProductsPage extends StatelessWidget {
  final String categoryId;
  final String categoryName;
  final String storeId;

  const CategoryProductsPage({
    super.key,
    required this.categoryId,
    required this.categoryName,
    required this.storeId,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              CategoriesCubit(getAllCategoriesUseCase: getIt())
                ..loadCategories(page: 1, limit: 100),
        ),
        BlocProvider(
          create: (context) => ProductsByCategoryCubit(
            getProductsByCategoryUseCase: getIt(),
            storeId: storeId,
          )..loadProducts(categoryId: categoryId),
        ),
      ],
      child: _CategoryProductsContent(
        initialCategoryId: categoryId,
        initialCategoryName: categoryName,
        storeId: storeId,
      ),
    );
  }
}

class _CategoryProductsContent extends StatefulWidget {
  final String initialCategoryId;
  final String initialCategoryName;
  final String storeId;

  const _CategoryProductsContent({
    required this.initialCategoryId,
    required this.initialCategoryName,
    required this.storeId,
  });

  @override
  State<_CategoryProductsContent> createState() =>
      _CategoryProductsContentState();
}

class _CategoryProductsContentState extends State<_CategoryProductsContent> {
  late String _selectedCategoryId;
  late String _selectedCategoryName;

  @override
  void initState() {
    super.initState();
    _selectedCategoryId = widget.initialCategoryId;
    _selectedCategoryName = widget.initialCategoryName;
  }

  void _onCategoryTap(CategoryEntity category) {
    if (_selectedCategoryId != category.id) {
      setState(() {
        _selectedCategoryId = category.id;
        _selectedCategoryName = category.name;
      });
      context.read<ProductsByCategoryCubit>().loadProducts(
        categoryId: category.id,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Text(
          _selectedCategoryName,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: BlocBuilder<CategoriesCubit, CategoriesState>(
            builder: (context, categoriesState) {
              return categoriesState.when(
                initial: () => const SizedBox.shrink(),
                loading: () => const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
                loaded: (categories) {
                  return SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        final isSelected = category.id == _selectedCategoryId;
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 8,
                          ),
                          child: GestureDetector(
                            onTap: () => _onCategoryTap(category),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? colorScheme.primary
                                    : colorScheme.surfaceContainer,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  category.name,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black87,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
                error: (message) => const SizedBox.shrink(),
              );
            },
          ),
        ),
      ),
      body: BlocBuilder<ProductsByCategoryCubit, ProductsByCategoryState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (products) {
              if (products.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_bag_outlined,
                        size: 80,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'لا توجد منتجات',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'هذا القسم فارغ حالياً',
                        style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () async {
                  context.read<ProductsByCategoryCubit>().refresh(
                    categoryId: _selectedCategoryId,
                  );
                },
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return ProductCard(
                      productData: products[index],
                      onAddToCart: () {
                        context.read<CartCubit>().addToCart(products[index]);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'تمت إضافة ${products[index].name} إلى السلة',
                            ),
                            duration: const Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            },
            error: (message) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 60, color: Colors.red[300]),
                  const SizedBox(height: 16),
                  Text(
                    'خطأ في تحميل المنتجات',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      message,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<ProductsByCategoryCubit>().refresh(
                        categoryId: _selectedCategoryId,
                      );
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('إعادة المحاولة'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
