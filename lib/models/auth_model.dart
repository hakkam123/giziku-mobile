class AuthRequest {
  final String email;
  final String password;
  final String? name;

  AuthRequest({
    required this.email,
    required this.password,
    this.name,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'email': email,
      'password': password,
    };

    if (name != null) {
      data['name'] = name;
    }

    return data;
  }
}

class LoginRequest {
  final String email;
  final String password;

  LoginRequest({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
  };
}

class RegisterRequest {
  final String email;
  final String password;
  final String name;
  final String? phoneNumber;
  final String? birthDate;
  final String? gender;

  RegisterRequest({
    required this.email,
    required this.password,
    required this.name,
    this.phoneNumber,
    this.birthDate,
    this.gender,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'email': email,
      'password': password,
      'name': name,
    };

    if (phoneNumber != null) data['phone_number'] = phoneNumber;
    if (birthDate != null) data['birth_date'] = birthDate;
    if (gender != null) data['gender'] = gender;

    return data;
  }
}

class AuthResponse {
  final bool success;
  final String? token;
  final String? message;
  final Map<String, dynamic>? userData;

  AuthResponse({
    required this.success,
    this.token,
    this.message,
    this.userData,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      success: json['success'] ?? false,
      token: json['token'],
      message: json['message'],
      userData: json['user_data'],
    );
  }

  factory AuthResponse.error(String errorMessage) {
    return AuthResponse(
      success: false,
      message: errorMessage,
    );
  }
}
