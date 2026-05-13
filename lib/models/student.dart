class Student {
  final String id;
  final String fullName;
  final String studentNumber;
  final String currentYear;
  final String moduleOne;
  final String? moduleTwo;
  final bool meetsRequirements;
  final String status;
  final String userId;
  final String? documentUrl;

  Student({
    required this.id,
    required this.fullName,
    required this.studentNumber,
    required this.currentYear,
    required this.moduleOne,
    this.moduleTwo,
    required this.meetsRequirements,
    required this.status,
    required this.userId,
    this.documentUrl,
  });

  // Convert JSON from Supabase -> Student Object
  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'].toString(),
      fullName: json['full_name'] ?? '',
      studentNumber: json['student_number'] ?? '',
      currentYear: json['current_year'] ?? '',
      moduleOne: json['module_one'] ?? '',
      moduleTwo: json['module_two'],
      meetsRequirements: json['meets_requirements'] ?? false,
      status: json['status'] ?? 'Pending',
      userId: json['user_id'].toString(),
      documentUrl: json['document_url'],
    );
  }

  // Convert Student Object -> JSON for Supabase
  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'student_number': studentNumber,
      'current_year': currentYear,
      'module_one': moduleOne,
      'module_two': moduleTwo,
      'meets_requirements': meetsRequirements,
      'status': status,
      'user_id': userId,
      'document_url': documentUrl,
    };
  }

  // CopyWith for updating objects
  Student copyWith({
    String? id,
    String? fullName,
    String? studentNumber,
    String? currentYear,
    String? moduleOne,
    String? moduleTwo,
    bool? meetsRequirements,
    String? status,
    String? userId,
    String? documentUrl,
  }) {
    return Student(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      studentNumber: studentNumber ?? this.studentNumber,
      currentYear: currentYear ?? this.currentYear,
      moduleOne: moduleOne ?? this.moduleOne,
      moduleTwo: moduleTwo ?? this.moduleTwo,
      meetsRequirements: meetsRequirements ?? this.meetsRequirements,
      status: status ?? this.status,
      userId: userId ?? this.userId,
      documentUrl: documentUrl ?? this.documentUrl,
    );
  }
}
