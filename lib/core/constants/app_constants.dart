class AppConstants {
  // App Metadata
  static const String appName = 'Store App';
  static const String appVersion = '1.0.0';

  // Storage Keys
  static const String storageKeyUserCredentials = 'user_credentials';
  static const String storageKeyUserPermissions = 'user_permissions';
  static const String storageKeyCart = 'cart_items';
  static const String storageKeyUserData = 'user_data';
  static const String storageKeyAuthToken = 'auth_token';

  // API Configuration
  static const int apiTimeoutSeconds = 30;
  static const int apiRetryCount = 3;

  // Pagination
  static const int defaultPageSize = 20;
  static const int defaultPageNumber = 1;

  // Date Format
  static const String dateFormat = 'yyyy-MM-dd';
  static const String dateTimeFormat = 'yyyy-MM-dd HH:mm:ss';

  // Error Messages
  static const String errorUnknown = 'An unknown error occurred';
  static const String errorNetwork = 'Network error occurred';
  static const String errorServer = 'Server error occurred';
  static const String errorCache = 'Cache error occurred';
  static const String errorValidation = 'Validation error occurred';
  static const String errorNotFound = 'Resource not found';
  static const String errorUnauthorized = 'Unauthorized access';
  static const String errorEmptyCart = 'Cart is empty';
  static const String errorInvalidCredentials = 'Invalid credentials';

  // Success Messages
  static const String successAddToCart = 'Item added to cart';
  static const String successRemoveFromCart = 'Item removed from cart';
  static const String successOrderPlaced = 'Order placed successfully';

  // Validation Messages
  static const String validationNameRequired = 'Name is required';
  static const String validationPhoneRequired = 'Phone is required';
  static const String validationAddressRequired = 'Address is required';
  static const String validationInvalidPhone = 'Invalid phone number';
  static const String validationInvalidEmail = 'Invalid email address';

  // Feature Permissions
  static const String permissionView = 'view';
  static const String permissionOrder = 'order';
  static const String permissionSearch = 'search';
  static const String permissionViewPrice = 'view_price';
}
