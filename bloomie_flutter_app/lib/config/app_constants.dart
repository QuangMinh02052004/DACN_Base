import 'package:flutter/material.dart';

class AppConstants {
  // App Info
  static const String appName = 'Bloomie';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Hệ thống bán hoa trực tuyến';

  // Storage Keys
  static const String keyToken = 'jwt_token';
  static const String keyRefreshToken = 'refresh_token';
  static const String keyUserId = 'user_id';
  static const String keyUserInfo = 'user_info';
  static const String keyThemeMode = 'theme_mode';
  static const String keyLanguage = 'language';
  static const String keyCart = 'cart_data';
  static const String keyRecentSearches = 'recent_searches';

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // Image
  static const int maxImageSizeKB = 5120; // 5MB
  static const double imageQuality = 0.8;

  // Cache Duration
  static const Duration cacheDuration = Duration(hours: 1);
  static const Duration shortCacheDuration = Duration(minutes: 15);

  // Animation Duration
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration normalAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);

  // Debounce Duration
  static const Duration searchDebounce = Duration(milliseconds: 500);

  // Default Values
  static const String defaultImageUrl = 'https://via.placeholder.com/300x300?text=No+Image';
  static const String defaultAvatarUrl = 'https://via.placeholder.com/150x150?text=User';

  // Currency
  static const String currencySymbol = '₫';
  static const String currencyCode = 'VND';

  // Date Format
  static const String dateFormat = 'dd/MM/yyyy';
  static const String dateTimeFormat = 'dd/MM/yyyy HH:mm';
  static const String timeFormat = 'HH:mm';

  // Order Status
  static const String orderStatusPending = 'Pending';
  static const String orderStatusConfirmed = 'Confirmed';
  static const String orderStatusProcessing = 'Processing';
  static const String orderStatusShipping = 'Shipping';
  static const String orderStatusDelivered = 'Delivered';
  static const String orderStatusCancelled = 'Cancelled';

  // Payment Methods
  static const String paymentCOD = 'COD';
  static const String paymentMomo = 'Momo';
  static const String paymentVNPay = 'VNPay';
  static const String paymentCard = 'Card';

  // Regex Patterns
  static final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  static final RegExp phoneRegex = RegExp(
    r'^[0-9]{10,11}$',
  );
  static final RegExp passwordRegex = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d@$!%*?&]{8,}$',
  );

  // Error Messages
  static const String errorNetwork = 'Lỗi kết nối mạng';
  static const String errorServer = 'Lỗi server';
  static const String errorUnknown = 'Đã xảy ra lỗi';
  static const String errorTimeout = 'Quá thời gian chờ';
  static const String errorUnauthorized = 'Phiên đăng nhập hết hạn';
  static const String errorNotFound = 'Không tìm thấy dữ liệu';

  // Success Messages
  static const String successLogin = 'Đăng nhập thành công';
  static const String successRegister = 'Đăng ký thành công';
  static const String successLogout = 'Đăng xuất thành công';
  static const String successAddToCart = 'Đã thêm vào giỏ hàng';
  static const String successRemoveFromCart = 'Đã xóa khỏi giỏ hàng';
  static const String successPlaceOrder = 'Đặt hàng thành công';
  static const String successCancelOrder = 'Hủy đơn hàng thành công';

  // Validation Messages
  static const String validationRequired = 'Trường này là bắt buộc';
  static const String validationEmail = 'Email không hợp lệ';
  static const String validationPhone = 'Số điện thoại không hợp lệ';
  static const String validationPassword = 'Mật khẩu phải có ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường và số';
  static const String validationPasswordMatch = 'Mật khẩu không khớp';
  static const String validationMinLength = 'Tối thiểu {0} ký tự';
  static const String validationMaxLength = 'Tối đa {0} ký tự';
}

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFFE91E63); // Pink
  static const Color primaryDark = Color(0xFFC2185B);
  static const Color primaryLight = Color(0xFFF8BBD0);

  // Secondary Colors
  static const Color secondary = Color(0xFF4CAF50); // Green
  static const Color secondaryDark = Color(0xFF388E3C);
  static const Color secondaryLight = Color(0xFFC8E6C9);

  // Accent Colors
  static const Color accent = Color(0xFFFF9800); // Orange
  static const Color accentLight = Color(0xFFFFE0B2);

  // Neutral Colors
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color grey = Color(0xFF9E9E9E);
  static const Color greyLight = Color(0xFFF5F5F5);
  static const Color greyDark = Color(0xFF616161);

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);

  // Background Colors
  static const Color background = Color(0xFFFAFAFA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color cardBackground = Color(0xFFFFFFFF);

  // Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFFBDBDBD);
  static const Color textDisabled = Color(0xFF9E9E9E);

  // Border Colors
  static const Color border = Color(0xFFE0E0E0);
  static const Color divider = Color(0xFFBDBDBD);

  // Rating Color
  static const Color rating = Color(0xFFFFB300);
}

class AppSizes {
  // Padding & Margin
  static const double paddingXS = 4.0;
  static const double paddingS = 8.0;
  static const double paddingM = 16.0;
  static const double paddingL = 24.0;
  static const double paddingXL = 32.0;

  // Border Radius
  static const double radiusXS = 4.0;
  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 24.0;
  static const double radiusCircle = 999.0;

  // Icon Sizes
  static const double iconXS = 16.0;
  static const double iconS = 20.0;
  static const double iconM = 24.0;
  static const double iconL = 32.0;
  static const double iconXL = 48.0;

  // Font Sizes
  static const double fontXS = 10.0;
  static const double fontS = 12.0;
  static const double fontM = 14.0;
  static const double fontL = 16.0;
  static const double fontXL = 18.0;
  static const double fontXXL = 20.0;
  static const double fontTitle = 24.0;
  static const double fontHeading = 28.0;

  // Button Heights
  static const double buttonHeightS = 36.0;
  static const double buttonHeightM = 44.0;
  static const double buttonHeightL = 52.0;

  // App Bar
  static const double appBarHeight = 56.0;
  static const double bottomNavHeight = 60.0;

  // Card
  static const double cardElevation = 2.0;
  static const double cardPadding = 16.0;

  // Image
  static const double avatarS = 32.0;
  static const double avatarM = 48.0;
  static const double avatarL = 64.0;
  static const double avatarXL = 96.0;

  // Product Card
  static const double productImageHeight = 200.0;
  static const double productCardWidth = 160.0;
}

class AppDurations {
  static const Duration splash = Duration(seconds: 2);
  static const Duration short = Duration(milliseconds: 200);
  static const Duration medium = Duration(milliseconds: 300);
  static const Duration long = Duration(milliseconds: 500);
  static const Duration veryLong = Duration(seconds: 1);
}
