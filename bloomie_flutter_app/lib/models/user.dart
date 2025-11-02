class User {
  final String userId;
  final String userName;
  final String email;
  final String? fullName;
  final String? phoneNumber;
  final String? avatar;
  final List<String> roles;
  final DateTime? createdAt;

  User({
    required this.userId,
    required this.userName,
    required this.email,
    this.fullName,
    this.phoneNumber,
    this.avatar,
    required this.roles,
    this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      userName: json['userName'],
      email: json['email'],
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
      avatar: json['avatar'],
      roles: List<String>.from(json['roles'] ?? []),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'email': email,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'avatar': avatar,
      'roles': roles,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  bool get isAdmin => roles.contains('Admin');
  bool get isStaff => roles.contains('Staff');
}

class AuthResponse {
  final bool success;
  final String? message;
  final String? token;
  final String? refreshToken;
  final DateTime? expiresAt;
  final User? user;

  AuthResponse({
    required this.success,
    this.message,
    this.token,
    this.refreshToken,
    this.expiresAt,
    this.user,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      success: json['success'] ?? false,
      message: json['message'],
      token: json['token'],
      refreshToken: json['refreshToken'],
      expiresAt: json['expiresAt'] != null
          ? DateTime.parse(json['expiresAt'])
          : null,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }
}
