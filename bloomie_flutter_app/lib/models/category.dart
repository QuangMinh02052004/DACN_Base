class Category {
  final int categoryId;
  final String categoryName;
  final String? description;
  final int? parentCategoryId;
  final String? parentCategoryName;
  final int productCount;
  final List<Category>? subCategories;

  Category({
    required this.categoryId,
    required this.categoryName,
    this.description,
    this.parentCategoryId,
    this.parentCategoryName,
    required this.productCount,
    this.subCategories,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      description: json['description'],
      parentCategoryId: json['parentCategoryId'],
      parentCategoryName: json['parentCategoryName'],
      productCount: json['productCount'] ?? 0,
      subCategories: json['subCategories'] != null
          ? (json['subCategories'] as List)
              .map((e) => Category.fromJson(e))
              .toList()
          : null,
    );
  }
}
