import 'package:car_rental_app/presentation/model/notification_model.dart';

class NotificationService {
  static final List<NotificationModel> _notifications = [];

  // Add a new notification
  static void addNotification(NotificationModel notification) {
    _notifications.add(notification);
  }

  // Retrieve all notifications
  static List<NotificationModel> getNotifications() {
    return _notifications;
  }
}
