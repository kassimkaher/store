import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:store_web/core/widgets/custom_bottom_nav.dart';
import 'package:store_web/core/widgets/skeleton_loading.dart';
import 'package:store_web/features/auth/cubit/auth_cubit.dart';
import 'package:store_web/features/auth/cubit/auth_state.dart';
import 'package:store_web/features/bookmarks/presentation/pages/bookmarks_page.dart';
import 'package:store_web/features/cart/presentation/pages/cart_page.dart';
import 'package:store_web/features/cart/presentation/pages/order_history_page.dart';
import 'package:store_web/features/home/presentation/pages/home_view.dart';

import '../utils/injector/injector.dart';
import 'category/presentation/cubit/categories_cubit.dart';
import 'offers/presentation/cubit/offers_cubit.dart';
import 'products/presentation/cubit/products_cubit.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  BottomNavItem _currentNavItem = BottomNavItem.home;

  @override
  void initState() {
    super.initState();
    // Remove splash screen after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FlutterNativeSplash.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      bloc: getIt<AuthCubit>(),
      builder: (context, authState) {
        return authState.when(
          initial: (data, loading, errorMessage) => const SkeletonLoading(),
          loading: (data, loading, errorMessage) => const SkeletonLoading(),
          authenticated: (data, loading, errorMessage) => _buildMainContent(),
          error: (data, loading, errorMessage) => _buildErrorView(errorMessage),
          unauthenticated: (data, loading, errorMessage) =>
              _buildErrorView('Not authenticated'),
        );
      },
    );
  }

  Widget _buildMainContent() {
    context.read<OffersCubit>().loadOffers();
    context.read<CategoriesCubit>().loadCategories();
    context.read<MostPurchasedCubit>().loadProducts();
    return RefreshIndicator(
      onRefresh: () async {
        context.read<OffersCubit>().refresh();
        context.read<CategoriesCubit>().refresh();
        context.read<MostPurchasedCubit>().refresh();
      },
      child: Scaffold(
        body: IndexedStack(
          index: _currentNavItem.index,
          children: const [
            HomeView(),
            BookmarksPage(),
            OrderHistoryPage(),
            CartPage(isBackButtonVisible: false),
          ],
        ),
        bottomNavigationBar: CustomBottomNav(
          currentItem: _currentNavItem,
          onItemSelected: (item) {
            setState(() {
              _currentNavItem = item;
            });
          },
        ),
      ),
    );
  }

  Widget _buildErrorView(String message) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'خطأ',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                getIt<AuthCubit>().loadAuthData();
              },
              child: const Text('إعادة المحاولة'),
            ),
          ],
        ),
      ),
    );
  }
}
