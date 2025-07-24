class UserProfile {
  final String name;
  final String email;
  final String phoneNumber;
  final String birthDate;
  final double? height;
  final double? weight;
  final String? photoUrl;

  UserProfile({
    required this.name,
    required this.email,
    this.phoneNumber = '',
    this.birthDate = '',
    this.height,
    this.weight,
    this.photoUrl,
  });

  // Factory method untuk membuat UserProfile dari JSON
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      birthDate: json['birth_date'] ?? '',
      height: json['height'] != null ? double.parse(json['height'].toString()) : null,
      weight: json['weight'] != null ? double.parse(json['weight'].toString()) : null,
      photoUrl: json['photo_url'],
    );
  }

  // Method untuk mengkonversi UserProfile ke JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone_number': phoneNumber,
      'birth_date': birthDate,
      'height': height,
      'weight': weight,
      'photo_url': photoUrl,
    };
  }

  // Method untuk membuat copy dari UserProfile dengan nilai baru
  UserProfile copyWith({
    String? name,
    String? email,
    String? phoneNumber,
    String? birthDate,
    double? height,
    double? weight,
    String? photoUrl,
  }) {
    return UserProfile(
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      birthDate: birthDate ?? this.birthDate,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
}
