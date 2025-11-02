class Order {
  final int orderId;
  final String orderCode;
  final DateTime orderDate;
  final String status;
  final double totalAmount;
  final String? customerName;
  final String? customerPhone;
  final String? shippingAddress;
  final String? paymentMethod;
  final String? paymentStatus;
  final DateTime? deliveryDate;
  final String? notes;

  Order({
    required this.orderId,
    required this.orderCode,
    required this.orderDate,
    required this.status,
    required this.totalAmount,
    this.customerName,
    this.customerPhone,
    this.shippingAddress,
    this.paymentMethod,
    this.paymentStatus,
    this.deliveryDate,
    this.notes,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json['orderId'],
      orderCode: json['orderCode'],
      orderDate: DateTime.parse(json['orderDate']),
      status: json['status'],
      totalAmount: (json['totalAmount'] as num).toDouble(),
      customerName: json['customerName'],
      customerPhone: json['customerPhone'],
      shippingAddress: json['shippingAddress'],
      paymentMethod: json['paymentMethod'],
      paymentStatus: json['paymentStatus'],
      deliveryDate: json['deliveryDate'] != null
          ? DateTime.parse(json['deliveryDate'])
          : null,
      notes: json['notes'],
    );
  }

  bool get isPending => status == 'Pending';
  bool get isConfirmed => status == 'Confirmed';
  bool get isProcessing => status == 'Processing';
  bool get isShipping => status == 'Shipping';
  bool get isDelivered => status == 'Delivered';
  bool get isCancelled => status == 'Cancelled';
  bool get canCancel => isPending || isConfirmed;
}

class OrderDetail extends Order {
  final List<OrderItem> orderItems;

  OrderDetail({
    required super.orderId,
    required super.orderCode,
    required super.orderDate,
    required super.status,
    required super.totalAmount,
    super.customerName,
    super.customerPhone,
    super.shippingAddress,
    super.paymentMethod,
    super.paymentStatus,
    super.deliveryDate,
    super.notes,
    required this.orderItems,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      orderId: json['orderId'],
      orderCode: json['orderCode'],
      orderDate: DateTime.parse(json['orderDate']),
      status: json['status'],
      totalAmount: (json['totalAmount'] as num).toDouble(),
      customerName: json['customerName'],
      customerPhone: json['customerPhone'],
      shippingAddress: json['shippingAddress'],
      paymentMethod: json['paymentMethod'],
      paymentStatus: json['paymentStatus'],
      deliveryDate: json['deliveryDate'] != null
          ? DateTime.parse(json['deliveryDate'])
          : null,
      notes: json['notes'],
      orderItems: (json['orderItems'] as List)
          .map((e) => OrderItem.fromJson(e))
          .toList(),
    );
  }
}

class OrderItem {
  final int orderDetailId;
  final int productId;
  final String productName;
  final String? productImage;
  final int quantity;
  final double unitPrice;
  final double totalPrice;

  OrderItem({
    required this.orderDetailId,
    required this.productId,
    required this.productName,
    this.productImage,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      orderDetailId: json['orderDetailId'],
      productId: json['productId'],
      productName: json['productName'],
      productImage: json['productImage'],
      quantity: json['quantity'],
      unitPrice: (json['unitPrice'] as num).toDouble(),
      totalPrice: (json['totalPrice'] as num).toDouble(),
    );
  }
}
