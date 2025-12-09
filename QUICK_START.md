# 🚀 Quick Start Guide - Store Mini App

## Project Structure Overview

Your Flutter Store Mini App is now ready with **Clean Architecture (DDD)** pattern. Here's what's implemented:

### ✅ Completed Features

- ✅ **Dependency Injection** with `Injectable` & `GetIt`
- ✅ **API Client** with `Dio` + error handling
- ✅ **State Management** with `Riverpod`
- ✅ **Data Models** with `Freezer` (auto serialization)
- ✅ **Clean Architecture** layers (Domain, Data, Presentation)
- ✅ **Error Handling** with Result type (Either)
- ✅ **Local Storage** with SharedPreferences
- ✅ **Routing** with GoRouter
- ✅ **Configurable Credentials & Permissions** from parent app

---

## 📋 File Structure

```
lib/
├── core/
│   ├── di/injection_container.dart         # DI setup
│   ├── error/failures.dart                 # Error types
│   ├── error/exceptions.dart               # Exception types
│   ├── network/dio_client.dart             # HTTP client
│   ├── storage/storage_service.dart        # SharedPreferences wrapper
│   ├── constants/app_constants.dart        # Constants & storage keys
│   └── utils/
│       ├── result.dart                     # Result<T> type
│       └── app_credentials.dart            # Config & credentials
│
├── features/items/
│   ├── domain/
│   │   ├── entities/item_entity.dart       # Domain models
│   │   ├── repositories/repositories.dart  # Repository interfaces
│   │   └── usecases/usecases.dart         # Business logic
│   │
│   ├── data/
│   │   ├── models/item_model.dart         # Freezer models
│   │   ├── datasources/
│   │   │   ├── item_remote_datasource.dart
│   │   │   ├── item_local_datasource.dart
│   │   │   └── cart_remote_datasource.dart
│   │   └── repositories/repositories_impl.dart
│   │
│   └── presentation/
│       ├── pages/home_page.dart            # Placeholder page
│       ├── widgets/                        # UI widgets (TODO)
│       └── providers/items_providers.dart  # Riverpod providers
│
├── config/
│   ├── store_app.dart                      # Main app widget
│   └── routes/app_routes.dart              # Routes config
│
├── main.dart                               # Entry point
└── ARCHITECTURE.md                         # Full documentation
```

---

## 🔌 Connection to Parent App

### Step 1: Pass Credentials from Parent

```dart
// In parent app
final storeConfig = StoreConfig(
  apiBaseUrl: 'https://your-api.com',
  credentials: AppCredentials(
    userId: parentUserId,
    token: authToken,
    userName: userName,
  ),
  permissions: AppPermissions(
    grantedPermissions: ['view', 'order', 'search'],
    canViewItems: true,
    canPlaceOrder: true,
  ),
);

await configureDependencies(storeConfig);
```

### Step 2: Share Storage Between Apps

The store uses `SharedPreferences` which is automatically shared on web:

```dart
// Access from parent app
final storage = await SharedPreferences.getInstance();
final cartJson = storage.getString('cart_items');
```

### Step 3: Navigate to Store

```dart
// Option 1: Direct navigation
Navigator.push(
  context,
  MaterialPageRoute(builder: (_) => const StoreApp()),
);

// Option 2: In WebView (if embedding in web)
WebView(
  initialUrl: 'http://localhost:8080', // Your store app URL
)
```

---

## 🛠️ Implementation Tasks

### 1. **Implement Screens** (in `presentation/pages/`)

```dart
// lib/features/items/presentation/pages/items_list_page.dart
class ItemsListPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsync = ref.watch(itemsNotifierProvider);
    
    // Load items on mount
    ref.listen(itemsNotifierProvider, (previous, next) {
      next.whenData((_) {
        ref.read(itemsNotifierProvider.notifier).fetchItems();
      });
    });
    
    return itemsAsync.when(
      data: (items) => ListView(
        children: items.map((item) => ItemCard(item: item)).toList(),
      ),
      loading: () => const LoadingWidget(),
      error: (error, _) => ErrorWidget(error: error),
    );
  }
}
```

### 2. **Create Reusable Widgets** (in `presentation/widgets/`)

```dart
// lib/features/items/presentation/widgets/item_card.dart
class ItemCard extends StatelessWidget {
  final Item item;
  
  const ItemCard({required this.item});
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          if (item.image != null) Image.network(item.image!),
          Text(item.name),
          Text('\$${item.discountedPrice}'),
          ElevatedButton(
            onPressed: () => _addToCart(context),
            child: const Text('Add to Cart'),
          ),
        ],
      ),
    );
  }
  
  void _addToCart(BuildContext context) {
    final cartItem = CartItem(
      id: UniqueKey().toString(),
      itemId: item.id,
      itemName: item.name,
      itemPrice: item.price,
      quantity: 1,
      itemImage: item.image,
    );
    
    // Use Riverpod to add to cart
    context.read(cartNotifierProvider.notifier).addItem(cartItem);
  }
}
```

### 3. **Implement Search** (in `presentation/pages/`)

```dart
// Use searchItemsProvider for real-time search
final searchResults = ref.watch(searchItemsProvider(searchQuery));
```

### 4. **Build Checkout Form** (in `presentation/pages/`)

```dart
class CheckoutPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends ConsumerState<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  late String name, phone, address;
  String? note;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Name'),
            onSaved: (value) => name = value!,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Phone'),
            onSaved: (value) => phone = value!,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Address'),
            onSaved: (value) => address = value!,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Note (optional)'),
            onSaved: (value) => note = value,
          ),
          ElevatedButton(
            onPressed: _submitOrder,
            child: const Text('Place Order'),
          ),
        ],
      ),
    );
  }

  Future<void> _submitOrder() async {
    if (!_formKey.currentState!.validate()) return;
    
    _formKey.currentState!.save();
    
    final cart = ref.read(cartNotifierProvider).value;
    if (cart == null || cart.items.isEmpty) return;
    
    final order = Order(
      id: UniqueKey().toString(),
      items: cart.items,
      totalAmount: cart.totalAmount,
      name: name,
      phone: phone,
      address: address,
      note: note,
    );
    
    final result = await ref.read(placeOrderUseCaseProvider)(order);
    
    result.fold(
      (failure) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${failure.message}')),
      ),
      (placedOrder) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Order placed successfully')),
        );
        ref.read(cartNotifierProvider.notifier).clearCart();
      },
    );
  }
}
```

### 5. **Update Routes** (in `config/routes/app_routes.dart`)

```dart
GoRoute(
  path: '/items',
  builder: (context, state) => const ItemsListPage(),
),
GoRoute(
  path: '/items/:id',
  builder: (context, state) {
    final id = state.pathParameters['id']!;
    return ItemDetailPage(itemId: id);
  },
),
GoRoute(
  path: '/cart',
  builder: (context, state) => const CartPage(),
),
GoRoute(
  path: '/checkout',
  builder: (context, state) => const CheckoutPage(),
),
```

---

## 📱 Example: Adding Item to Cart

```dart
ConsumerWidget(
  build: (context, ref) {
    return ElevatedButton(
      onPressed: () async {
        final cartItem = CartItem(
          id: Uuid().v4(),
          itemId: item.id,
          itemName: item.name,
          itemPrice: item.price,
          quantity: 1,
        );
        
        // Add to cart using Riverpod notifier
        await ref.read(cartNotifierProvider.notifier).addItem(cartItem);
      },
      child: const Text('Add to Cart'),
    );
  },
)
```

---

## 🔗 Calling APIs

The Dio client is configured with your API base URL. Make requests like:

```dart
// Get items
final items = await dioClient.get<List>('/items?page=1&pageSize=20');

// Search
final results = await dioClient.get('/items/search?q=laptop');

// Place order
final order = await dioClient.post(
  '/orders',
  data: {'name': 'John', 'phone': '123', ...},
);
```

---

## 💾 Storage Keys

Your app uses these keys for SharedPreferences:

- `cart_items` - Stores cart data
- `user_credentials` - User authentication data
- `user_permissions` - User permissions
- `user_data` - Additional user data
- `auth_token` - Auth token

Access via:
```dart
final storage = getIt<StorageService>();
final cart = await storage.getString('cart_items');
```

---

## 🚨 Important Notes

1. **API Base URL**: Update in `main.dart` before running
2. **Credentials**: Pass from parent app on startup
3. **Code Generation**: Run `flutter pub run build_runner build` when adding new models
4. **Error Handling**: Always use `.fold()` for Result types
5. **State Management**: Use Riverpod, avoid Provider package

---

## 📚 Resources

- **Full Documentation**: See `ARCHITECTURE.md`
- **Riverpod Docs**: https://riverpod.dev
- **Clean Architecture**: https://www.oreilly.com/library/view/clean-architecture/9780134494272/
- **Freezer**: https://pub.dev/packages/freezed

---

## ✉️ Next Steps

1. Implement UI screens using the widgets pattern shown
2. Connect your actual API endpoints
3. Test cart functionality with real data
4. Add form validation for checkout
5. Handle permissions in UI
6. Test integration with parent app

**You're all set! 🎉 Start building your store screens!**
