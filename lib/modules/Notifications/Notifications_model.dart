


class NotificationsModel {
  final String createdAt;
  final List<NotificationItem> notifications;

  NotificationsModel({
    required this.createdAt,
    required this.notifications,
  });

  factory NotificationsModel.fromJson(Map<String, dynamic> json) {
    return NotificationsModel(
      createdAt: json['createdAt'],
      notifications: (json['notifications'] as List)
          .map((e) => NotificationItem.fromJson(e))
          .toList(),
    );
  }
}

class NotificationItem {
  final int id;
  final String title;
  final String body;
  final bool read;
  final String createdAt;

  NotificationItem({
    required this.id,
    required this.title,
    required this.body,
    required this.read,
    required this.createdAt,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      id: json['id'],
      title: json['title'],
      body: json['body'] ?? "",
      read: json['read'] ?? false,
      createdAt: json['createdAt'],
    );
  }
}
