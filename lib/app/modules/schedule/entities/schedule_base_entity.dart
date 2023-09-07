class ScheduleBaseEntity {
  final String? id;
  final String? title;
  final String? notes;
  final String? date;
  final String? time;
  final String? priority;
  final String? category;
  final bool? isActive;

  ScheduleBaseEntity({
    this.id,
    this.title,
    this.notes,
    this.date,
    this.time,
    this.priority,
    this.category,
    this.isActive,
  });

  factory ScheduleBaseEntity.fromFirestoreData(Map<String, dynamic> data) {
    return ScheduleBaseEntity(
      id: data['id'] ?? '',
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
