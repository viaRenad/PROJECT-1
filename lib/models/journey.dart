class Journey {
  final String id;
  final String userId;
  final String title;
  final String status;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final DateTime createdAt;

  Journey({
    required this.id,
    required this.userId,
    required this.title,
    required this.status,
    this.startedAt,
    this.completedAt,
    required this.createdAt,
  });

  factory Journey.fromJson(Map<String, dynamic> json) {
    return Journey(
      id: json['id'],
      userId: json['user_id'],
      title: json['title'],
      status: json['status'],
      startedAt:
          json['started_at'] != null
              ? DateTime.parse(json['started_at'])
              : null,
      completedAt:
          json['completed_at'] != null
              ? DateTime.parse(json['completed_at'])
              : null,
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
