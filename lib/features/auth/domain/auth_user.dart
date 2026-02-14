class AuthUser {
  const AuthUser({
    required this.token,
    required this.role,
    required this.email,
  });

  final String token;
  final String role;
  final String email;

  Map<String, String> toStorageMap() {
    return {
      'token': token,
      'role': role,
      'email': email,
    };
  }

  factory AuthUser.fromStorageMap(Map<String, String> source) {
    return AuthUser(
      token: source['token'] ?? '',
      role: source['role'] ?? 'Borrower',
      email: source['email'] ?? '',
    );
  }
}
