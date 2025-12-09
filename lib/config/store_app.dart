import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:store_web/core/theme/theme_app.dart';
import 'package:store_web/features/auth/cubit/auth_cubit.dart';
import 'package:store_web/features/bookmarks/presentation/cubit/bookmark_cubit.dart';
import 'package:store_web/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:store_web/features/category/presentation/cubit/categories_cubit.dart';
import 'package:store_web/features/offers/presentation/cubit/offers_cubit.dart';
import 'package:store_web/features/products/presentation/cubit/products_cubit.dart';

import '../core/utils/app_credentials.dart';
import '../utils/injector/injector.dart';
import 'routes/app_routes.dart';

// Global theme configuration based on HTML design
final colorScheme = ColorScheme(
  brightness: Brightness.light,
  // Primary colors
  primary: Color(0xFF005292),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFF005292),
  onPrimaryContainer: Color(0xFFFFFFFF),
  // Secondary colors
  secondary: Color(0xFFEFF0EF),
  onSecondary: Color(0xFF4A5250),
  secondaryContainer: Color(0xFFEFF0EF),
  onSecondaryContainer: Color(0xFF4A5250),
  // Error/Destructive colors
  error: Color(0xFFC87A7A),
  onError: Color(0xFFFFFFFF),
  errorContainer: Color(0xFFC87A7A),
  onErrorContainer: Color(0xFFFFFFFF),
  // Surface/Card colors
  surface: Color(0xFFFAFBFA),
  onSurface: Color(0xFF4A5250),
  surfaceContainerHighest: Color(0xFFE5E8E6),
  onSurfaceVariant: Color(0xFF8A9290),
  // Outline/Border colors
  outline: Color(0xFFE5E8E6),
  outlineVariant: Color(0xFF9AA59F),
  shadow: Colors.black,
  scrim: Colors.black,
  inverseSurface: Color(0xFF4A5250),
  onInverseSurface: Color(0xFFFAFBFA),
  inversePrimary: Color(0xFF9AA59F),
);

final textTheme = TextTheme(
  displayLarge: GoogleFonts.balooBhaijaan2(
    fontSize: 57,
    fontWeight: FontWeight.w400,
  ),
  displayMedium: GoogleFonts.balooBhaijaan2(
    fontSize: 45,
    fontWeight: FontWeight.w400,
  ),
  displaySmall: GoogleFonts.balooBhaijaan2(
    fontSize: 36,
    fontWeight: FontWeight.w400,
  ),
  headlineLarge: GoogleFonts.balooBhaijaan2(
    fontSize: 32,
    fontWeight: FontWeight.w700,
  ),
  headlineMedium: GoogleFonts.balooBhaijaan2(
    fontSize: 28,
    fontWeight: FontWeight.w700,
  ),
  headlineSmall: GoogleFonts.balooBhaijaan2(
    fontSize: 24,
    fontWeight: FontWeight.w700,
  ),
  titleLarge: GoogleFonts.balooBhaijaan2(
    fontSize: 20,
    fontWeight: FontWeight.w700,
  ),
  titleMedium: GoogleFonts.balooBhaijaan2(
    fontSize: 16,
    fontWeight: FontWeight.w700,
  ),
  titleSmall: GoogleFonts.balooBhaijaan2(
    fontSize: 14,
    fontWeight: FontWeight.w700,
  ),
  bodyLarge: GoogleFonts.balooBhaijaan2(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  ),
  bodyMedium: GoogleFonts.balooBhaijaan2(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  ),
  bodySmall: GoogleFonts.balooBhaijaan2(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  ),
  labelLarge: GoogleFonts.balooBhaijaan2(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  ),
  labelMedium: GoogleFonts.balooBhaijaan2(
    fontSize: 12,
    fontWeight: FontWeight.w500,
  ),
  labelSmall: GoogleFonts.balooBhaijaan2(
    fontSize: 10,
    fontWeight: FontWeight.w500,
  ),
).apply(displayColor: Color(0xFF4A5250), bodyColor: Color(0xFF4A5250));

class StoreApp extends StatelessWidget {
  final StoreConfig? config;

  const StoreApp({super.key, this.config});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = AppRoutes.router;

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<AuthCubit>()..loadAuthData()),
        BlocProvider(
          create: (context) => OffersCubit(getOffersUseCase: getIt()),
        ),
        BlocProvider(
          create: (context) =>
              CategoriesCubit(getAllCategoriesUseCase: getIt()),
        ),
        BlocProvider.value(value: getIt<MostPurchasedCubit>()),
        BlocProvider.value(value: getIt<CartCubit>()),
        BlocProvider.value(value: getIt<BookmarkCubit>()),
      ],
      child: MaterialApp.router(
        title: 'Store App',

        theme: AppTheme.lightTheme,
        locale: Locale("ar"),
        supportedLocales: const [
          Locale('ar'), // English
          Locale('en'), // Spanish
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        routerConfig: router,
        builder: (context, child) => Scaffold(
          appBar: AppBar(
            backgroundColor: colorScheme.surface,
            title: Text(""),
            surfaceTintColor: Colors.transparent,
            foregroundColor: Colors.black.withAlpha(0),
            shadowColor: Colors.teal.withAlpha(0),
          ),
          body: Padding(padding: EdgeInsets.only(top: 0), child: child!),
        ),
      ),
    );
  }
}
