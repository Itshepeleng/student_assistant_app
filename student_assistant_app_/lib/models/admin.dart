
class AdminStats {
  final int totalApplications;
  final int pendingCount;
  final int approvedCount;
  final int rejectedCount;
  final String lastUpdated;

  AdminStats({
    required this.totalApplications,
    required this.pendingCount,
    required this.approvedCount,
    required this.rejectedCount,
    required this.lastUpdated,
  });

  // Factory to create stats from a list of Student applications
  factory AdminStats.fromStudentList(List<dynamic> students) {
    return AdminStats(
      totalApplications: students.length,
      pendingCount: students.where((s) => s.status == 'Pending').length,
      approvedCount: students.where((s) => s.status == 'Approved').length,
      rejectedCount: students.where((s) => s.status == 'Rejected').length,
      lastUpdated: DateTime.now().toString(),
    );
  }

  // Initial empty state
  factory AdminStats.empty() {
    return AdminStats(
      totalApplications: 0,
      pendingCount: 0,
      approvedCount: 0,
      rejectedCount: 0,
      lastUpdated: 'Never',
    );
  }
}


class AdminAction {
  final String? id;
  final String adminId;
  final String actionType; // 'APPROVE', 'REJECT', 'DELETE'
  final String targetApplicationId;
  final DateTime timestamp;

  AdminAction({
    this.id,
    required this.adminId,
    required this.actionType,
    required this.targetApplicationId,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
    'admin_id': adminId,
    'action_type': actionType,
    'target_id': targetApplicationId,
    'created_at': timestamp.toIso8601String(),
  };
}
