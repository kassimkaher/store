import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_web/core/widgets/custom_bottom_nav.dart';
import 'package:store_web/features/auth/cubit/auth_cubit.dart';
import 'package:store_web/features/bookmarks/presentation/pages/bookmarks_page.dart';
import 'package:store_web/features/cart/presentation/pages/cart_page.dart';
import 'package:store_web/features/cart/presentation/pages/order_history_page.dart';
import 'package:store_web/features/home/presentation/pages/home_view.dart';

import '../core/di/injection_container.dart';
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
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<AuthCubit>()..loadAuthData()),
        BlocProvider(
          create: (context) => OffersCubit(
            getOffersUseCase: getIt(),
            storeId: getIt<AuthCubit>().getStorId() ?? '',
          )..loadOffers(),
        ),
        BlocProvider(
          create: (context) => CategoriesCubit(
            getAllCategoriesUseCase: getIt(),
            storeId: getIt<AuthCubit>().getStorId() ?? '',
          )..loadCategories(),
        ),
        BlocProvider(
          create: (context) => MostPurchasedCubit(
            getMostPurchasedUseCase: getIt(),
            storeId: getIt<AuthCubit>().getStorId() ?? '',
          )..loadProducts(),
        ),
      ],
      child: RefreshIndicator(
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
              CartPage(),
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
      ),
    );
  }
}
