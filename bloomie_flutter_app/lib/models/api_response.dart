class ApiResponse<T> {
  final bool success;
  final String? message;
  final T? data;
  final List<String>? errors;
  final PaginationMeta? meta;

  ApiResponse({
    required this.success,
    this.message,
    this.data,
    this.errors,
    this.meta,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic)? fromJsonT,
  ) {
    return ApiResponse<T>(
      success: json['success'] ?? false,
      message: json['message'],
      data: json['data'] != null && fromJsonT != null
          ? fromJsonT(json['data'])
          : json['data'],
      errors: json['errors'] != null
          ? List<String>.from(json['errors'])
          : null,
      meta: json['meta'] != null
          ? PaginationMeta.fromJson(json['meta'])
          : null,
    );
  }

  bool get isSuccess => success && data != null;
  bool get hasError => !success || errors != null;
}

class PaginationMeta {
  final int currentPage;
  final int pageSize;
  final int totalPages;
  final int totalCount;
  final bool hasPrevious;
  final bool hasNext;

  PaginationMeta({
    required this.currentPage,
    required this.pageSize,
    required this.totalPages,
    required this.totalCount,
    required this.hasPrevious,
    required this.hasNext,
  });

  factory PaginationMeta.fromJson(Map<String, dynamic> json) {
    return PaginationMeta(
      currentPage: json['currentPage'] ?? 1,
      pageSize: json['pageSize'] ?? 20,
      totalPages: json['totalPages'] ?? 0,
      totalCount: json['totalCount'] ?? 0,
      hasPrevious: json['hasPrevious'] ?? false,
      hasNext: json['hasNext'] ?? false,
    );
  }
}
