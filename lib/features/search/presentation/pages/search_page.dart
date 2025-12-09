import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_web/features/auth/cubit/auth_cubit.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/widgets/custom_search_bar.dart';
import '../../../../core/widgets/product_card.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';
import '../../../products/domain/entities/product_entity.dart';
import '../../domain/entities/search_result_entity.dart';
import '../cubit/search_cubit.dart';
import '../cubit/search_state.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(
        searchAllUseCase: getIt(),
        storeId: getIt<AuthCubit>().state.maybeWhen(
          authenticated: (data, v, b) => data.storeId,
          orElse: () => '',
        ),
      ),
      child: _SearchPageContent(
        storeId: getIt<AuthCubit>().state.maybeWhen(
          authenticated: (data, v, b) => data.storeId,
          orElse: () => '',
        ),
      ),
    );
  }
}

class _SearchPageContent extends StatefulWidget {
  final String storeId;

  const _SearchPageContent({required this.storeId});

  @override
  State<_SearchPageContent> createState() => _SearchPageState();
}

enum SearchFilter { all, products, offers }

class _SearchPageState extends State<_SearchPageContent> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  final SearchFilter _currentFilter = SearchFilter.all;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    // Auto-focus on search field when page opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    setState(() {
      _searchQuery = query;
    });
    context.read<SearchCubit>().search(query);
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _searchQuery = '';
    });
    context.read<SearchCubit>().clear();
  }

  List<SearchResult> _filterResults(List<SearchResult> results) {
    switch (_currentFilter) {
      case SearchFilter.products:
        return results
            .where((r) => r.type == SearchResultType.product)
            .toList();
      case SearchFilter.offers:
        return results.where((r) => r.type == SearchResultType.offer).toList();
      case SearchFilter.all:
        return results;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'البحث',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Filter Chips
            Expanded(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => _buildEmptyState(
                      icon: Icons.search,
                      title: 'ابدأ البحث',
                      message: 'أدخل كلمات البحث للعثور على المنتجات والعروض',
                    ),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    loaded: (results, query) {
                      final filteredResults = _filterResults(results);

                      if (filteredResults.isEmpty) {
                        return _buildEmptyState(
                          icon: Icons.search_off,
                          title: 'لا توجد نتائج',
                          message: 'جرب كلمات بحث أخرى',
                        );
                      }

                      return GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.7,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                            ),
                        itemCount: filteredResults.length,
                        itemBuilder: (context, index) {
                          final result = filteredResults[index];
                          final product = ProductEntity(
                            id: result.id,
                            name: result.title,
                            price: result.price ?? 0,
                            description: result.description,
                            image: result.image,
                            categoryId: null,
                            categoryName:
                                result.type == SearchResultType.product
                                ? 'منتج'
                                : 'عرض',
                            isLiked: false,
                            baseUrl: '',
                          );

                          return ProductCard(
                            productData: product,
                            onAddToCart: () {
                              context.read<CartCubit>().addToCart(product);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'تمت إضافة ${product.name} إلى السلة',
                                  ),
                                  duration: const Duration(seconds: 2),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                    error: (message) => _buildEmptyState(
                      icon: Icons.error_outline,
                      title: 'خطأ',
                      message: message,
                      actionLabel: 'إعادة المحاولة',
                      onAction: () => _performSearch(_searchQuery),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomSearchBar(
            controller: _searchController,
            focusNode: _searchFocusNode,
            autofocus: true,
            hintText: 'ابحث عن المنتجات والعروض...',
            onChanged: (value) {
              // Debounce search to avoid too many API calls
              Future.delayed(const Duration(milliseconds: 500), () {
                if (_searchController.text == value) {
                  _performSearch(value);
                }
              });
            },
            onSubmitted: _performSearch,
            suffixIcon: _searchQuery.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: _clearSearch,
                  )
                : null,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Text(
              message,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ),
          if (actionLabel != null && onAction != null) ...[
            const SizedBox(height: 24),
            ElevatedButton(onPressed: onAction, child: Text(actionLabel)),
          ],
        ],
      ),
    );
  }
}
