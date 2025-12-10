import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:store_web/config/store_app.dart';
import 'package:store_web/core/widgets/skeleton_widgets.dart';
import 'package:store_web/features/auth/cubit/auth_cubit.dart';
import 'package:store_web/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:store_web/features/cart/presentation/cubit/cart_state.dart';
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
            // AppBar(
            //   flexibleSpace: CustomAppBar(
            //     location:
            //         getIt<AuthCubit>().currentAuthData?.name ??
            //         "Unknown Location",
            //     address:
            //         getIt<AuthCubit>().currentAuthData?.storeName ??
            //         "Unknown Location",
            //     hasNotification: true,
            //     onLocationTap: () {},
            //     onNotificationTap: () {},
            //     onCartTap: () {},
            //   ),
            // ),
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
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomSearchBar(
                              readOnly: true,
                              onTap: () {
                                context.push('/search');
                              },
                            ),
                          ),
                          BlocBuilder<CartCubit, CartState>(
                            builder: (context, cartState) {
                              final itemCount = context
                                  .read<CartCubit>()
                                  .itemCount;
                              return Stack(
                                children: [
                                  Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      color:
                                          colorScheme.surfaceContainerHighest,
                                      shape: BoxShape.circle,
                                    ),
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: PhosphorIcon(
                                        PhosphorIcons.shoppingCart(
                                          PhosphorIconsStyle.duotone,
                                        ),
                                        size: 25,
                                        color: colorScheme.onSecondaryContainer,
                                      ),
                                      onPressed: () {
                                        context.push('/cart/true');
                                      },
                                    ),
                                  ),
                                  if (itemCount > 0)
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                        constraints: const BoxConstraints(
                                          minWidth: 18,
                                          minHeight: 18,
                                        ),
                                        child: Text(
                                          itemCount > 99 ? '99+' : '$itemCount',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    OfferSlider(),
                    const SizedBox(height: 8),
                    // Categories Section
                    BlocBuilder<CategoriesCubit, CategoriesState>(
                      builder: (context, state) {
                        return state.when(
                          initial: () => const SizedBox.shrink(),
                          loading: () => const CategoriesGridSkeleton(),
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
                                loading: () => const ProductsGridSkeleton(),
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
