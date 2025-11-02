class Product {
  final int productId;
  final String productName;
  final String? description;
  final double price;
  final double? discountedPrice;
  final int stockQuantity;
  final bool isAvailable;
  final int? categoryId;
  final String? categoryName;
  final String? primaryImage;
  final List<String>? images;
  final double? averageRating;
  final int totalRatings;
  final List<String>? flowerTypes;

  Product({
    required this.productId,
    required this.productName,
    this.description,
    required this.price,
    this.discountedPrice,
    required this.stockQuantity,
    required this.isAvailable,
    this.categoryId,
    this.categoryName,
    this.primaryImage,
    this.images,
    this.averageRating,
    required this.totalRatings,
    this.flowerTypes,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['productId'],
      productName: json['productName'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      discountedPrice: json['discountedPrice'] != null
          ? (json['discountedPrice'] as num).toDouble()
          : null,
      stockQuantity: json['stockQuantity'] ?? 0,
      isAvailable: json['isAvailable'] ?? true,
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      primaryImage: json['primaryImage'],
      images: json['images'] != null
          ? List<String>.from(json['images'])
          : null,
      averageRating: json['averageRating'] != null
          ? (json['averageRating'] as num).toDouble()
          : null,
      totalRatings: json['totalRatings'] ?? 0,
      flowerTypes: json['flowerTypes'] != null
          ? List<String>.from(json['flowerTypes'])
          : null,
    );
  }

  double get displayPrice => discountedPrice ?? price;
  bool get hasDiscount => discountedPrice != null && discountedPrice! < price;
  double get discountPercentage => hasDiscount
      ? ((price - discountedPrice!) / price * 100)
      : 0;
}
