class Account {
  final String id;
  final String username;
  final String email;
  final String fullName;
  final String phone;
  final String role;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? lastLogin;
  final String avatarUrl;

  const Account({
    required this.id,
    required this.username,
    required this.email,
    required this.fullName,
    required this.phone,
    required this.role,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.lastLogin,
    required this.avatarUrl,
  });

  List<Object?> get props => [
        id,
        username,
        email,
        fullName,
        phone,
        role,
        status,
        createdAt,
        updatedAt,
        lastLogin,
        avatarUrl,
      ];
}