import 'package:car_rental_app/presentation/services/notification_services.dart';
import 'package:flutter/material.dart';
 // Import your notification service


class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notifications = NotificationService.getNotifications();

    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        backgroundColor: Color(0xFF6672C1),
      ),
      body: notifications.isEmpty
          ? Center(
              child: Text(
                'No notifications available',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return ListTile(
                  title: Text(notification.title),
                  subtitle: Text(notification.message),
                  trailing: Text(
                    '${notification.timestamp.hour}:${notification.timestamp.minute}',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  isThreeLine: true,
                );
              },
            ),
    );
  }
}
