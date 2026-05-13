class Student {
  final String id;
  final String name;
  final String phone;
  final String? profilePictureUrl; // NEW: Optional image URL
  final String userId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String currentYear;
  final String status;
  final String modules;

  Student({
    required this.id,
    required this.name,
    required this.phone,
    this.profilePictureUrl,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.currentYear,
    required this.status,
    required this.modules,
  });

  Student copyWith({
    String? name,
    String? phone,
    String? profilePictureUrl,
    DateTime? updatedAt,
    String? userId,
    String? id,
    DateTime? createdAt,
    String? currentYear,
    String? status,
    String? modules,
  }) {
    return Student(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      currentYear: currentYear ?? this.currentYear,
      status: status ?? this.status,
      modules: modules ?? this.modules,
    );
  }

// Convert JSON → Student (from Supabase)
  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      profilePictureUrl: json['profile_picture_url'],
      userId: json['user_id'].toString(),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      currentYear: json['current year'] ?? '',
      status: json['status'] ?? '',
      modules: json['modules'] ?? '',
    );
  }

// Convert Student → JSON (for Supabase)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      if (profilePictureUrl != null) 'profile_picture_url': profilePictureUrl,
    };
  }
}
