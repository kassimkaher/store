# Store Mini App - Clean Architecture Implementation

A Flutter mini-app store module built with **Clean Architecture (DDD)**, **Freezer** for data models, **Riverpod** for state management, **Injectable** for dependency injection, and **Dio** for API communication.

## 🎯 Architecture Overview

### Core Structure

```
lib/
├── core/
│   ├── di/                      # Dependency Injection setup
│   ├── error/                   # Failures & Exceptions
│   ├── network/                 # Dio HTTP client
│   ├── storage/                 # Shared Preferences wrapper
│   ├── constants/               # App-wide constants
│   └── utils/                   # Utilities (Result, Credentials, etc.)
│
├── features/
│   └── items/                   # Main feature (Items, Categories, Cart)
│       ├── data/
│       │   ├── datasources/     # Remote & Local data sources
│       │   ├── models/          # Freezer models for serialization
│       │   └── repositories/    # Repository implementations
│       ├── domain/
│       │   ├── entities/        # Domain entities (business logic)
│       │   ├── repositories/    # Repository interfaces
│       │   └── usecases/        # Business logic usecases
│       └── presentation/
│           ├── pages/           # UI screens
│           ├── widgets/         # Reusable components
│           └── providers/       # Riverpod state management
│
├── config/
│   ├── store_app.dart          # Main app widget
│   └── routes/
│       └── app_routes.dart      # Navigation configuration
│
└── main.dart                    # Entry point
```

## 🏗️ Key Components

### 1. **Domain Layer (Business Logic)**

- **Entities**: Pure domain models (`Item`, `Category`, `Cart`, `Order`)
- **Repositories**: Interfaces defining data access contracts
- **Usecases**: Business logic encapsulated in dedicated classes

```dart
// Example: Getting items
final result = await GetAllItemsUseCase(repository).call(page: 1, pageSize: 20);
result.fold(
  (failure) => print('Error: ${failure.message}'),
  (items) => print('Success: ${items.length} items'),
);
```

### 2. **Data Layer (API & Storage)**

- **Remote Datasources**: Dio-based API clients
- **Local Datasources**: Shared Preferences for caching (cart, auth)
- **Models**: Freezer-generated models with JSON serialization
- **Repositories**: Concrete implementations handling error mapping

```dart
// Automatic JSON serialization
final item = ItemModel.fromJson(json);
final json = item.toJson();
```

### 3. **Presentation Layer (UI & State Management)**

- **Riverpod Providers**: Reactive state management without BuildContext
- **State Notifiers**: CartNotifier, ItemsNotifier managing complex states
- **Screens**: Pages displaying data
- **Widgets**: Reusable UI components

```dart
// Using Riverpod providers
final items = ref.watch(itemsNotifierProvider);
```

## 🔧 Setup & Configuration

### Initialize the App

```dart
import 'core/di/injection_container.dart';
import 'core/utils/app_credentials.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Configure credentials from parent app
  const storeConfig = StoreConfig(
    apiBaseUrl: 'https://api.example.com',
    credentials: AppCredentials(
      userId: 'user123',
      token: 'auth_token_here',
    ),
    permissions: AppPermissions(
      grantedPermissions: ['view', 'order', 'search'],
      canViewItems: true,
      canPlaceOrder: true,
      canViewPrice: true,
    ),
    enableLogging: true,
  );

  // Setup dependency injection
  await configureDependencies(storeConfig);

  runApp(
    const ProviderScope(child: StoreApp()),
  );
}
```

### Configure API Base URL

Update in `main.dart`:
```dart
const storeConfig = StoreConfig(
  apiBaseUrl: 'https://your-api.com',  // Your API endpoint
  // ... other config
);
```

## 📡 API Endpoints Required

The store app expects the following API endpoints:

### Items
- `GET /items?page=1&pageSize=20` - Get all items
- `GET /items/:id` - Get item by ID
- `GET /items/search?q=query&page=1&pageSize=20` - Search items
- `GET /categories/:categoryId/items` - Get items by category

### Categories
- `GET /categories` - Get all categories
- `GET /categories/:id` - Get category by ID

### Orders
- `POST /orders` - Place an order
- `GET /orders/:id` - Get order by ID
- `GET /orders?page=1&pageSize=20` - Get user orders

## 💾 Data Models

### Item
```dart
ItemModel(
  id: 'item_id',
  name: 'Product Name',
  description: 'Description',
  price: 99.99,
  categoryId: 'cat_1',
  image: 'https://example.com/image.jpg',
  quantity: 10,
  isAvailable: true,
  discount: 10,  // percentage
  sku: 'SKU123',
)
```

### Cart Item
```dart
CartItem(
  id: 'cart_item_1',
  itemId: 'item_1',
  itemName: 'Product Name',
  itemPrice: 99.99,
  quantity: 2,
  itemImage: 'https://example.com/image.jpg',
)
```

### Order Request
```dart
Order(
  id: 'order_1',
  items: [cartItem1, cartItem2],
  totalAmount: 199.98,
  name: 'John Doe',
  phone: '+1234567890',
  address: '123 Main St, City',
  note: 'Special instructions',
  status: 'pending',
)
```

## 🚀 Using the Mini App

### From Parent App

```dart
import 'package:store_web/config/store_app.dart';
import 'package:store_web/core/di/injection_container.dart';
import 'package:store_web/core/utils/app_credentials.dart';

// In parent app
final storeConfig = StoreConfig(
  apiBaseUrl: 'https://api.example.com',
  credentials: AppCredentials(
    userId: parentUserId,
    token: parentAppToken,
  ),
  permissions: AppPermissions(
    grantedPermissions: ['view', 'order'],
  ),
);

await configureDependencies(storeConfig);

// Open store in WebView or Navigator
navigator.push(
  MaterialPageRoute(builder: (_) => const StoreApp()),
);
```

### Access Cart from Parent App

```dart
// Share storage via get_it
final storageService = getIt<StorageService>();

// Read cart
final cart = await storageService.getJson<Map<String, dynamic>>(
  AppConstants.storageKeyCart,
  fromJson: (json) => json,
);

// Listen to cart changes with Riverpod
ref.watch(cartNotifierProvider);
```

## 🔐 Permissions System

Control feature access via `AppPermissions`:

```dart
AppPermissions(
  grantedPermissions: ['view', 'order', 'search', 'view_price'],
  canViewItems: true,      // Show product catalog
  canPlaceOrder: true,     // Allow checkout
  canSearch: true,         // Enable search feature
  canViewPrice: true,      // Show prices
)
```

In UI, check permissions:
```dart
if (config.permissions.canPlaceOrder) {
  // Show checkout button
}
```

## 🛠️ State Management with Riverpod

### Load Items
```dart
class ItemsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsync = ref.watch(itemsNotifierProvider);
    
    ref.listen(itemsNotifierProvider, (_, state) {
      state.whenData((_) => print('Items loaded'));
    });

    return itemsAsync.when(
      data: (items) => ListView(
        children: items.map((item) => ItemTile(item: item)).toList(),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('Error: $error')),
    );
  }
}
```

### Manage Cart
```dart
ref.read(cartNotifierProvider.notifier).addItem(cartItem);
ref.read(cartNotifierProvider.notifier).removeItem(itemId);
ref.read(cartNotifierProvider.notifier).updateQuantity(itemId, newQty);
ref.read(cartNotifierProvider.notifier).clearCart();
```

### Search Items
```dart
final searchResults = ref.watch(searchItemsProvider('laptop'));

searchResults.when(
  data: (results) => Text('Found ${results.items.length} items'),
  loading: () => const CircularProgressIndicator(),
  error: (err, _) => Text('Search failed'),
);
```

## 📝 Error Handling

The app uses `Result<T>` type (Either) for type-safe error handling:

```dart
final result = await useCase.call();

result.fold(
  (failure) {
    // Handle error
    final message = failure.message;
    final code = failure.code;
  },
  (data) {
    // Handle success
  },
);
```

Failure types:
- `ServerFailure` - API errors
- `NetworkFailure` - Connection issues
- `CacheFailure` - Storage errors
- `ValidationFailure` - Input validation
- `UnauthorizedFailure` - Auth issues
- `NotFoundFailure` - Resource not found

## 🔄 Storage Layer

All data uses `shared_preferences` for web compatibility:

```dart
// Save cart locally
await storageService.setJson(
  AppConstants.storageKeyCart,
  cartModel,
  toJson: (model) => model.toJson(),
);

// Retrieve cart
final cart = await storageService.getJson(
  AppConstants.storageKeyCart,
  fromJson: (json) => CartModel.fromJson(json),
);
```

## 🎨 Customization

### Change API Base URL
Update in `main.dart` before calling `configureDependencies`

### Add Custom Headers
```dart
final dioClient = getIt<DioClient>();
dioClient.updateHeaders({'X-Custom-Header': 'value'});
dioClient.updateAuthToken(newToken);
```

### Modify Storage Keys
Update in `lib/core/constants/app_constants.dart`

## 📚 Dependencies

- **flutter_riverpod**: State management
- **freezed_annotation**: Data class generation
- **dio**: HTTP client
- **dartz**: Functional programming (Either)
- **equatable**: Value equality
- **go_router**: Navigation
- **shared_preferences**: Local storage
- **injectable**: Dependency injection
- **get_it**: Service locator

## 🧪 Testing

Repositories and usecases are mockable:

```dart
// Mock repository
class MockItemRepository extends Mock implements ItemRepository {}

test('should fetch items', () async {
  final mockRepo = MockItemRepository();
  final useCase = GetAllItemsUseCase(mockRepo);
  
  when(mockRepo.getAllItems()).thenAnswer(
    (_) async => Right([item1, item2]),
  );
  
  final result = await useCase();
  expect(result.isRight(), true);
});
```

## 📖 Next Steps

1. Implement screens in `features/items/presentation/pages/`
2. Add widgets in `features/items/presentation/widgets/`
3. Implement your specific API endpoints
4. Add form validation for checkout
5. Integrate with parent app navigation

## 📞 Support

For issues or questions about the architecture, refer to the Clean Architecture principles and the code structure above.
