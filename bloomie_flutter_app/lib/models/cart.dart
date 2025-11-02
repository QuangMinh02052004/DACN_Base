class Cart {
  final int cartId;
  final String userId;
  final List<CartItem> items;
  final int totalItems;
  final double subTotal;
  final double? discountAmount;
  final double totalAmount;
  final DateTime? updatedAt;

  Cart({
    required this.cartId,
    required this.userId,
    required this.items,
    required this.totalItems,
    required this.subTotal,
    this.discountAmount,
    required this.totalAmount,
    this.updatedAt,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      cartId: json['cartId'],
      userId: json['userId'],
      items: (json['items'] as List)
          .map((e) => CartItem.fromJson(e))
          .toList(),
      totalItems: json['totalItems'] ?? 0,
      subTotal: (json['subTotal'] as num).toDouble(),
      discountAmount: json['discountAmount'] != null
          ? (json['discountAmount'] as num).toDouble()
          : null,
      totalAmount: (json['totalAmount'] as num).toDouble(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }

  bool get isEmpty => items.isEmpty;
  bool get isNotEmpty => items.isNotEmpty;
}

class CartItem {
  final int cartItemId;
  final int productId;
  final String productName;
  final String? productImage;
  final double price;
  final int quantity;
  final double totalPrice;
  final int stockQuantity;
  final bool isAvailable;

  CartItem({
    required this.cartItemId,
    required this.productId,
    required this.productName,
    this.productImage,
    required this.price,
    required this.quantity,
    required this.totalPrice,
    required this.stockQuantity,
    required this.isAvailable,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      cartItemId: json['cartItemId'],
      productId: json['productId'],
      productName: json['productName'],
      productImage: json['productImage'],
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'],
      totalPrice: (json['totalPrice'] as num).toDouble(),
      stockQuantity: json['stockQuantity'] ?? 0,
      isAvailable: json['isAvailable'] ?? true,
    );
  }
}
