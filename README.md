# 🛍️ Store Mini App - Flutter Clean Architecture Implementation

A production-ready **Flutter Store Mini App** built with **Clean Architecture (DDD)**, **Riverpod**, **Freezer**, **Dio**, and **Injectable**. Designed to be integrated as a module into any parent Flutter application.

## ✨ Features

- ✅ **Clean Architecture** - Separated Domain, Data, and Presentation layers
- ✅ **DDD (Domain-Driven Design)** - Business logic at the core
- ✅ **Riverpod** - Type-safe reactive state management
- ✅ **Freezer** - Auto-generated immutable models with JSON serialization
- ✅ **Injectable** - Compile-time dependency injection
- ✅ **Dio** - Robust HTTP client with interceptors
- ✅ **GoRouter** - Modern navigation configuration
- ✅ **SharedPreferences** - Cross-app accessible local storage
- ✅ **Error Handling** - Result type for type-safe error management
- ✅ **Configurable** - Credentials & permissions from parent app

## 🎯 What's Implemented

### Core Infrastructure
- [x] Dependency Injection with GetIt + Injectable
- [x] HTTP Client with Dio (request logging, error handling)
- [x] Storage Service with SharedPreferences
- [x] Error Handling (Failures & Exceptions)
- [x] Result Type (Either pattern with Dartz)
- [x] App Configuration & Credentials system
- [x] Permission system for feature gates

### Domain Layer (Business Logic)
- [x] 6 Domain entities (Item, Category, CartItem, Cart, Order, SearchResult)
- [x] 4 Repository interfaces
- [x] 13 Usecases for all operations

### Data Layer (API & Storage)
- [x] Remote datasources for Items, Categories, Orders
- [x] Local datasource for Cart persistence
- [x] 6 Freezer models with JSON serialization
- [x] 4 Repository implementations with error mapping

### Presentation Layer (UI & State)
- [x] Riverpod providers (25+)
- [x] State notifiers for Items, Categories, Cart
- [x] Family providers for search & filtering
- [x] Router configuration with GoRouter
- [x] Placeholder home page

## 📁 Project Structure

```
lib/
├── core/                          # Shared infrastructure
│   ├── di/                        # Dependency injection
│   ├── error/                     # Failures & exceptions
│   ├── network/                   # Dio HTTP client
│   ├── storage/                   # SharedPreferences wrapper
│   ├── constants/                 # App constants
│   └── utils/                     # Utilities & helpers
│
├── features/items/                # Main feature module
│   ├── data/
│   │   ├── datasources/          # Remote & local data sources
│   │   ├── models/               # Freezer auto-generated models
│   │   └── repositories/         # Repository implementations
│   ├── domain/
│   │   ├── entities/             # Business domain models
│   │   ├── repositories/         # Repository interfaces
│   │   └── usecases/             # Business logic
│   └── presentation/
│       ├── pages/                # UI screens (placeholder)
│       ├── widgets/              # Reusable components (TODO)
│       └── providers/            # Riverpod state management
│
├── config/
│   ├── store_app.dart            # Main app widget
│   └── routes/                   # Navigation routes
│
└── main.dart                      # Entry point
```

## 🚀 Quick Start

### 1. Setup

```bash
cd store_web
flutter pub get
```

### 2. Configure API Endpoint

Edit `lib/main.dart`:
```dart
const storeConfig = StoreConfig(
  apiBaseUrl: 'https://your-api.com',  // Your API endpoint
  // ... other config
);
```

### 3. Run

```bash
flutter run
```

## 📡 Required API Endpoints

Your backend should provide:

```
# Items
GET    /items?page=:page&pageSize=:size
GET    /items/:id
GET    /items/search?q=:query
GET    /categories/:categoryId/items

# Categories
GET    /categories
GET    /categories/:id

# Orders
POST   /orders
GET    /orders/:id
GET    /orders?page=:page&pageSize=:size
```

## 🔗 Integration with Parent App

### Method 1: Direct Navigation

```dart
// In parent app
Navigator.push(
  context,
  MaterialPageRoute(builder: (_) => const StoreApp()),
);
```

### Method 2: With Credentials

```dart
// Pass credentials before opening
final storeConfig = StoreConfig(
  apiBaseUrl: 'https://api.example.com',
  credentials: AppCredentials(
    userId: parentUserId,
    token: authToken,
  ),
  permissions: AppPermissions(
    grantedPermissions: ['view', 'order'],
    canPlaceOrder: userIsPremium,
  ),
);

await configureDependencies(storeConfig);
```

## 📚 Documentation

- **[ARCHITECTURE.md](ARCHITECTURE.md)** - Complete architecture documentation
- **[QUICK_START.md](QUICK_START.md)** - Quick implementation guide
- **[INTEGRATION_GUIDE.md](INTEGRATION_GUIDE.md)** - Parent app integration
- **[IMPLEMENTATION_SUMMARY.md](IMPLEMENTATION_SUMMARY.md)** - What's been done

## 💻 Example: Add Item to Cart

```dart
ConsumerWidget(
  build: (context, ref) {
    return ElevatedButton(
      onPressed: () {
        final cartItem = CartItem(
          id: Uuid().v4(),
          itemId: item.id,
          itemName: item.name,
          itemPrice: item.price,
          quantity: 1,
        );
        
        ref.read(cartNotifierProvider.notifier).addItem(cartItem);
      },
      child: const Text('Add to Cart'),
    );
  },
)
```

## 🔐 Credentials & Permissions

### Configure at Startup

```dart
const storeConfig = StoreConfig(
  credentials: AppCredentials(
    userId: 'user123',
    token: 'jwt_token',
    userName: 'John Doe',
    userEmail: 'john@example.com',
  ),
  permissions: AppPermissions(
    grantedPermissions: ['view', 'order', 'search'],
    canViewItems: true,
    canPlaceOrder: true,
    canSearch: true,
    canViewPrice: true,
  ),
);
```

### Check in UI

```dart
if (config.permissions.canPlaceOrder) {
  // Show checkout button
}
```

## 💾 Shared Storage

Cart data is automatically saved to SharedPreferences and accessible from parent app:

```dart
final prefs = await SharedPreferences.getInstance();
final cartJson = prefs.getString('cart_items');
```

## 🛠️ Technologies Used

| Package | Purpose | Version |
|---------|---------|---------|
| `flutter_riverpod` | State management | ^2.5.1 |
| `freezed_annotation` | Immutable models | ^2.4.1 |
| `dio` | HTTP client | ^5.4.3 |
| `go_router` | Navigation | ^14.2.0 |
| `shared_preferences` | Local storage | ^2.2.3 |
| `injectable` | Dependency injection | ^2.2.2 |
| `get_it` | Service locator | ^7.6.4 |
| `dartz` | Functional programming | ^0.10.1 |
| `equatable` | Value equality | ^2.0.5 |

## 📊 Project Statistics

| Metric | Count |
|--------|-------|
| **Domain Entities** | 6 |
| **Repository Interfaces** | 4 |
| **Usecases** | 13 |
| **Data Models** | 6 |
| **Datasources** | 3 |
| **Repository Implementations** | 4 |
| **Riverpod Providers** | 25+ |
| **Error Types** | 8 |
| **Total Dart Files** | 20+ |

## 🎨 Next Steps

Implement these screens:
- [ ] Items list page
- [ ] Item detail page  
- [ ] Search page
- [ ] Cart page
- [ ] Checkout form
- [ ] Order confirmation
- [ ] Order history

## 🧪 Testing

All components are designed to be testable - check repositories and usecases for mockability.

## 📝 Notes

- **Code Generation**: Run `flutter pub run build_runner build` when adding new Freezer models
- **Error Handling**: Always use `.fold()` for Result types
- **State Management**: Use Riverpod, avoid setState
- **API Base URL**: Configure before running app
- **SharedPreferences**: Data is shared across app boundary

## 🚀 Deployment

### Build Web
```bash
flutter build web
```

### Build Mobile
```bash
flutter build apk      # Android
flutter build ipa      # iOS
```

## 📞 Support

For implementation help, see [QUICK_START.md](QUICK_START.md) and [INTEGRATION_GUIDE.md](INTEGRATION_GUIDE.md).

---

**Built with ❤️ using Flutter Clean Architecture**

🎉 **Ready to implement! Start with [QUICK_START.md](QUICK_START.md)**
