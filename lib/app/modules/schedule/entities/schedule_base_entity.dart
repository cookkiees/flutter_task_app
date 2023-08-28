class ScheduleBaseEntity {
  final String title;
  final String notes;
  final String date;
  final String time;
  final String priority;
  final String category;
  final bool isActive;

  ScheduleBaseEntity({
    required this.title,
    required this.notes,
    required this.date,
    required this.time,
    required this.priority,
    required this.category,
    required this.isActive,
  });

  factory ScheduleBaseEntity.fromFirestoreData(Map<String, dynamic> data) {
    return ScheduleBaseEntity(
      title: data['title'] ?? '',
      notes: data['notes'] ?? '',
      date: data['date'] ?? '',
      time: data['time'] ?? '',
      priority: data['priority'] ?? '',
      category: data['category'] ?? '',
      isActive: data['is_active'] ?? false,
    );
  }
}
