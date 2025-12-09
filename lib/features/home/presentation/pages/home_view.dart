import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:store_web/core/widgets/custom_app_bar.dart';
import 'package:store_web/features/auth/cubit/auth_cubit.dart';
import 'package:store_web/features/category/presentation/cubit/categories_cubit.dart';
import 'package:store_web/features/category/presentation/cubit/categories_state.dart';
import 'package:store_web/features/category/presentation/widgets/category_grid_widget.dart';
import 'package:store_web/features/home/presentation/pages/offer_slider.dart';
import 'package:store_web/features/products/presentation/cubit/products_cubit.dart';
import 'package:store_web/features/products/presentation/cubit/products_state.dart';
import 'package:store_web/features/products/presentation/widgets/most_purchased_widget.dart';
import 'package:store_web/utils/injector/injector.dart';

import '../../../../core/widgets/custom_search_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppBar(
              flexibleSpace: CustomAppBar(
                location:
                    getIt<AuthCubit>().currentAuthData?.phone ??
                    "Unknown Location",
                address:
                    getIt<AuthCubit>().currentAuthData?.name ??
                    "Unknown Location",
                hasNotification: true,
                onLocationTap: () {},
                onNotificationTap: () {},
                onCartTap: () {},
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 16,
                  children: [
                    // Search Bar
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: CustomSearchBar(
                        readOnly: true,
                        onTap: () {
                          context.go('/search');
                        },
                      ),
                    ),

                    OfferSlider(),
                    const SizedBox(height: 8),
                    // Categories Section
                    BlocBuilder<CategoriesCubit, CategoriesState>(
                      builder: (context, state) {
                        return state.when(
                          initial: () => const SizedBox.shrink(),
                          loading: () => const SizedBox(
                            height: 200,
                            child: Center(child: CircularProgressIndicator()),
                          ),
                          loaded: (categories) => CategoryGridWidget(
                            categories: categories,
                            storeId:
                                getIt<AuthCubit>().currentAuthData?.storeId ??
                                '',
                          ),
                          error: (message) => SizedBox(
                            height: 200,
                            child: Center(
                              child: Text('Error loading categories: $message'),
                            ),
                          ),
                        );
                      },
                    ),

                    // Recent Arrivals Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('الاكثر طلباً', style: textTheme.titleLarge),

                          const SizedBox(height: 16),

                          BlocBuilder<MostPurchasedCubit, MostPurchasedState>(
                            builder: (context, state) {
                              return state.when(
                                initial: () => const SizedBox.shrink(),
                                loading: () => const SizedBox(
                                  height: 200,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                                loaded: (products) =>
                                    MostPurchasedWidget(products: products),
                                error: (message) => SizedBox(
                                  height: 200,
                                  child: Center(
                                    child: Text(
                                      'Error loading products: $message',
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 96), // Bottom padding for nav bar
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
