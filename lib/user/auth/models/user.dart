// lib/user/auth/models/user.dart
class User {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String phone;
  final DateTime birthDate;
  final String socialSecurityNumber;
  final DateTime? lastConsultation;
  final String? doctorName;
  final String? profilePicture;
  final DateTime createdAt;
  final DateTime? lastLogin;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.birthDate,
    required this.socialSecurityNumber,
    this.lastConsultation,
    this.doctorName,
    this.profilePicture,
    required this.createdAt,
    this.lastLogin,
  });

  // JSON serialization
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      phone: json['phone'] ?? '',
      birthDate: DateTime.parse(json['birthDate']),
      socialSecurityNumber: json['socialSecurityNumber'] ?? '',
      lastConsultation: json['lastConsultation'] != null 
          ? DateTime.parse(json['lastConsultation'])
          : null,
      doctorName: json['doctorName'],
      profilePicture: json['profilePicture'],
      createdAt: DateTime.parse(json['createdAt']),
      lastLogin: json['lastLogin'] != null
          ? DateTime.parse(json['lastLogin'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'birthDate': birthDate.toIso8601String(),
      'socialSecurityNumber': socialSecurityNumber,
      'lastConsultation': lastConsultation?.toIso8601String(),
      'doctorName': doctorName,
      'profilePicture': profilePicture,
      'createdAt': createdAt.toIso8601String(),
      'lastLogin': lastLogin?.toIso8601String(),
    };
  }

  // Helper pour l'inscription
  factory User.fromRegistrationData({
    required String id,
    required String email,
    required String firstName,
    required String lastName,
    required String phone,
    required DateTime birthDate,
    required String socialSecurityNumber,
    DateTime? lastConsultation,
    String? doctorName,
  }) {
    return User(
      id: id,
      email: email,
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      birthDate: birthDate,
      socialSecurityNumber: socialSecurityNumber,
      lastConsultation: lastConsultation,
      doctorName: doctorName,
      createdAt: DateTime.now(),
      lastLogin: DateTime.now(),
    );
  }

  String get fullName => '$firstName $lastName';

  User copyWith({
    String? id,
    String? email,
    String? firstName,
    String? lastName,
    String? phone,
    DateTime? birthDate,
    String? socialSecurityNumber,
    DateTime? lastConsultation,
    String? doctorName,
    String? profilePicture,
    DateTime? createdAt,
    DateTime? lastLogin,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      birthDate: birthDate ?? this.birthDate,
      socialSecurityNumber: socialSecurityNumber ?? this.socialSecurityNumber,
      lastConsultation: lastConsultation ?? this.lastConsultation,
      doctorName: doctorName ?? this.doctorName,
      profilePicture: profilePicture ?? this.profilePicture,
      createdAt: createdAt ?? this.createdAt,
      lastLogin: lastLogin ?? this.lastLogin,
    );
  }

  // Getters utiles
  int get age {
    final now = DateTime.now();
    return now.year - birthDate.year - 
        (now.month < birthDate.month || 
         (now.month == birthDate.month && now.day < birthDate.day) ? 1 : 0);
  }

  bool get hasCompleteProfile => 
      firstName.isNotEmpty && 
      lastName.isNotEmpty && 
      phone.isNotEmpty && 
      socialSecurityNumber.isNotEmpty;
}