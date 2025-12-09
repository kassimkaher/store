# Integration Guide - Store Mini App with Parent App

## 🔗 How to Integrate Store Mini App into Your Parent App

This guide explains how to use the Store Mini App as a module within your parent Flutter application.

---

## 📦 Integration Methods

### Method 1: Direct Package Import (Recommended for Web)

#### Step 1: Add to Parent App's `pubspec.yaml`

```yaml
dependencies:
  store_web:
    path: ../store_web

  # Make sure these are also in parent app
  flutter_riverpod: ^2.5.1
  shared_preferences: ^2.2.3
```

#### Step 2: Initialize in Parent App's `main.dart`

```dart
import 'package:store_web/core/di/injection_container.dart';
import 'package:store_web/core/utils/app_credentials.dart';
import 'package:store_web/config/store_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Get parent app's credentials
  final parentUserId = 'parent_user_123';
  final parentToken = 'jwt_token_from_parent';

  // Create store configuration
  final storeConfig = StoreConfig(
    apiBaseUrl: 'https://api.example.com',
    credentials: AppCredentials(
      userId: parentUserId,
      token: parentToken,
      userName: 'John Doe',
      userEmail: 'john@example.com',
    ),
    permissions: AppPermissions(
      grantedPermissions: ['view', 'order', 'search', 'view_price'],
      canViewItems: true,
      canPlaceOrder: true,
      canSearch: true,
      canViewPrice: true,
    ),
    enableLogging: false, // Disable logging in production
  );

  // Setup DI for store app
  await configureDependencies(storeConfig);

  runApp(
    const ProviderScope(
      child: MyParentApp(),
    ),
  );
}

class MyParentApp extends StatelessWidget {
  const MyParentApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ... your parent app config
      home: const ParentHomePage(),
    );
  }
}
```

#### Step 3: Navigate to Store App

```dart
// From parent app screen
ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const StoreApp()),
    );
  },
  child: const Text('Open Store'),
)
```

---

### Method 2: Navigation with Go Router

If your parent app uses GoRouter:

```dart
// In parent app's router config
final goRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const ParentHomePage(),
    ),
    GoRoute(
      path: '/store',
      builder: (context, state) => const StoreApp(),
    ),
    GoRoute(
      path: '/store/items/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'];
        return StoreApp(); // Handle routing internally
      },
    ),
  ],
);
```

Navigate using:
```dart
context.go('/store');
```

---

## 🔐 Shared Storage Between Apps

### Accessing Cart Data from Parent App

```dart
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_web/core/constants/app_constants.dart';

class ParentApp {
  Future<void> getCartData() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Get cart items
    final cartJson = prefs.getString(AppConstants.storageKeyCart);
    if (cartJson != null) {
      print('Cart data: $cartJson');
    }
  }
}
```

### Listening to Cart Changes

Use Riverpod from parent app:

```dart
import 'package:store_web/features/items/presentation/providers/items_providers.dart';

class CartBadge extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartAsync = ref.watch(cartNotifierProvider);
    
    return cartAsync.when(
      data: (cart) => Badge(
        label: Text(cart.itemCount.toString()),
        child: const Icon(Icons.shopping_cart),
      ),
      loading: () => const Icon(Icons.shopping_cart),
      error: (_, __) => const Icon(Icons.shopping_cart),
    );
  }
}
```

---

## 🌐 WebView Integration (For Web Embedding)

If embedding Store App in a WebView:

```dart
// Parent app wraps Store in WebView
import 'webview_flutter/webview_flutter.dart';

class StoreWebView extends StatefulWidget {
  @override
  _StoreWebViewState createState() => _StoreWebViewState();
}

class _StoreWebViewState extends State<StoreWebView> {
  late WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: 'http://localhost:8080/store', // Your store app URL
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (controller) {
        _webViewController = controller;
      },
      navigationDelegate: (NavigationRequest request) {
        // Handle app-specific URLs
        if (request.url.contains('action=checkout')) {
          // Pass control back to parent app
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      },
    );
  }
}
```

---

## 🔄 Passing Data Between Apps

### From Parent → Store App

```dart
// Before navigating, configure the store
const storeConfig = StoreConfig(
  apiBaseUrl: yourApiUrl,
  credentials: AppCredentials(
    userId: parentAppUserId,
    token: parentAppAuthToken,
  ),
  permissions: AppPermissions(
    grantedPermissions: parentUserPermissions,
  ),
);

await configureDependencies(storeConfig);

// Navigate
Navigator.push(context, MaterialPageRoute(builder: (_) => const StoreApp()));
```

### From Store → Parent App

Use SharedPreferences or callback patterns:

```dart
// Store app saves data
await storageService.setString('parent_action', 'order_placed');

// Parent app reads it
final action = await prefs.getString('parent_action');
if (action == 'order_placed') {
  // Handle order placed event
}
```

Or use a callback:

```dart
// Pass callback when opening store
class StoreAppWrapper extends ConsumerWidget {
  final Function(Order) onOrderPlaced;
  
  const StoreAppWrapper({required this.onOrderPlaced});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(placeOrderUseCaseProvider, (_, state) {
      state.whenData((order) => onOrderPlaced(order));
    });
    
    return const StoreApp();
  }
}
```

---

## 🎛️ Customizing Store Behavior

### Control Feature Access

```dart
final storeConfig = StoreConfig(
  permissions: AppPermissions(
    grantedPermissions: [
      if (userIsPremium) 'order',
      'search',
      'view',
    ],
    canViewItems: true,
    canPlaceOrder: userIsPremium,
    canSearch: true,
    canViewPrice: userIsLoggedIn,
  ),
);
```

### Change API Endpoint

```dart
final storeConfig = StoreConfig(
  apiBaseUrl: environment == 'prod' 
    ? 'https://api.prod.com'
    : 'https://api.dev.com',
);
```

### Debug Mode

```dart
final storeConfig = StoreConfig(
  enableLogging: true, // Show API logs
  requestTimeoutSeconds: 30, // API timeout
);
```

---

## 🚀 Deployment Scenarios

### Scenario 1: Mobile App with Store Feature

```dart
// Parent app (mobile)
void main() async {
  await initializeApp();
  
  // Setup store before running
  await configureDependencies(storeConfig);
  
  runApp(const ProviderScope(child: MyMobileApp()));
}
```

### Scenario 2: Web App with Store Module

```dart
// Parent app (web)
void main() async {
  // Setup store as a sub-route
  setupStoreModule();
  
  runApp(const ProviderScope(child: MyWebApp()));
}

void setupStoreModule() async {
  await configureDependencies(storeConfig);
}
```

### Scenario 3: Desktop App with Store

```dart
// Parent app (desktop)
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Setup store module
  await configureDependencies(storeConfig);
  
  runApp(const ProviderScope(child: MyDesktopApp()));
}
```

---

## 🔌 API Authentication

### Using Parent App's Auth Token

```dart
// Get token from parent app
final authToken = await parentApp.getAuthToken();

// Pass to store
final storeConfig = StoreConfig(
  credentials: AppCredentials(
    token: authToken,
    userId: parentApp.userId,
  ),
);

await configureDependencies(storeConfig);
```

### Update Token on Refresh

```dart
// If token refreshes in parent app
final newToken = await refreshAuthToken();

// Update store's Dio client
final dioClient = getIt<DioClient>();
dioClient.updateAuthToken(newToken);
```

---

## 📊 Shared State Management

Both parent and store use Riverpod, so you can share providers:

```dart
// Create a shared provider
final currentUserProvider = Provider<User>((ref) {
  // Access parent app's user state
  return parentUserState;
});

// Use in store
class StorePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    return Text('Welcome ${currentUser.name}');
  }
}
```

---

## ⚠️ Important Considerations

1. **Dependency Versions**: Ensure parent app and store app have compatible dependency versions
2. **Provider Scope**: Both apps need `ProviderScope` at the root
3. **Navigation**: Handle navigation appropriately based on your app structure
4. **Storage**: SharedPreferences data is shared on same device
5. **API Base URL**: Must be configured before using store
6. **Permissions**: Set appropriate permissions before opening store

---

## 🧪 Testing Integration

### Mock the Store Config

```dart
testWidgets('Store integration test', (WidgetTester tester) async {
  const storeConfig = StoreConfig(
    apiBaseUrl: 'http://localhost:3000', // Mock API
    credentials: AppCredentials(
      userId: 'test_user',
      token: 'test_token',
    ),
  );

  await configureDependencies(storeConfig);

  await tester.pumpWidget(
    const ProviderScope(
      child: MaterialApp(home: StoreApp()),
    ),
  );

  expect(find.byType(StoreApp), findsOneWidget);
});
```

---

## 📝 Troubleshooting

### Store Not Loading

```dart
// Ensure DI is initialized
if (getIt.isRegistered<DioClient>()) {
  print('Store initialized correctly');
} else {
  print('ERROR: Store not initialized');
  await configureDependencies(storeConfig);
}
```

### Shared Storage Not Working

```dart
// Verify SharedPreferences access
final prefs = await SharedPreferences.getInstance();
final keys = prefs.getKeys();
print('Stored keys: $keys');
```

### API Authentication Issues

```dart
// Check if token is being passed correctly
final dioClient = getIt<DioClient>();
print('Headers: ${dioClient._dio.options.headers}');
```

---

## 📞 Support

For integration issues:
1. Check `ARCHITECTURE.md` for component details
2. Verify all dependencies are installed
3. Ensure DI initialization happens before navigation
4. Check API endpoint configuration
5. Review error logs in debug mode

---

**Integration complete! Your store is now part of your parent app. 🎉**
