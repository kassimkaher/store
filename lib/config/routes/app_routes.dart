import 'package:go_router/go_router.dart';
import 'package:store_web/features/category/presentation/pages/category_products_page.dart';

import '../../features/bookmarks/presentation/pages/bookmarks_page.dart';
import '../../features/cart/presentation/pages/cart_page.dart';
import '../../features/cart/presentation/pages/order_history_page.dart';
import '../../features/main_page.dart';
import '../../features/products/presentation/pages/product_detail_page.dart';
import '../../features/search/presentation/pages/search_page.dart';

class AppRoutes {
  static const String home = '/';
  static const String design = '/design';
  static const String itemDetail = '/item/:id';
  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String search = '/search';
  static const String bookmarks = '/bookmarks';
  static const String productDetail = '/product/:id';
  static const String categoryProducts = '/category/:id/:categoryName/:storeId';
  static const String orderHistory = '/orders';

  // Default storeId - in a real app, this would come from configuration or user session

  static final GoRouter router = GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(
        path: home,
        name: 'home',
        builder: (context, state) => const MainPage(),
      ),
      GoRoute(
        path: design,
        name: 'design',
        builder: (context, state) => const MainPage(),
      ),
      GoRoute(
        path: itemDetail,
        name: 'itemDetail',
        builder: (context, state) {
          return const MainPage(); // Placeholder - will implement detail page
        },
      ),
      GoRoute(
        path: cart,
        name: 'cart',
        builder: (context, state) => const CartPage(),
      ),
      GoRoute(
        path: checkout,
        name: 'checkout',
        builder: (context, state) => const MainPage(), // Placeholder
      ),
      GoRoute(
        path: search,
        name: 'search',
        builder: (context, state) => const SearchPage(),
      ),
      GoRoute(
        path: bookmarks,
        name: 'bookmarks',
        builder: (context, state) => const BookmarksPage(),
      ),
      GoRoute(
        path: productDetail,
        name: 'productDetail',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return ProductDetailPage(productId: id);
        },
      ),
      GoRoute(
        path: orderHistory,
        name: 'orderHistory',
        builder: (context, state) => const OrderHistoryPage(),
      ),
      GoRoute(
        path: categoryProducts,
        name: 'categoryProducts',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          final categoryName = state.pathParameters['categoryName']!;
          final storeId = state.pathParameters['storeId']!;
          return CategoryProductsPage(
            categoryId: id,
            categoryName: categoryName,
            storeId: storeId,
          );
        },
      ),
    ],
  );
}
