import '../entities/schedule_base_entity.dart';

class ScheduleViewModel {
  final String id;

  final String title;
  final String notes;
  final String date;
  final String time;
  final String priority;
  final String category;
  final bool isActive;

  ScheduleViewModel(
      {required this.id,
      required this.title,
      required this.notes,
      required this.date,
      required this.time,
      required this.priority,
      required this.category,
      required this.isActive,
      s});
  factory ScheduleViewModel.fromEntity(ScheduleBaseEntity data) {
    return ScheduleViewModel(
      id: "${data.id}",
      title: "${data.title}",
      notes: "${data.notes}",
      date: "${data.date}",
      time: "${data.time}",
      priority: "${data.priority}",
      category: "${data.category}",
      isActive: data.isActive ?? false,
    );
  }
}
