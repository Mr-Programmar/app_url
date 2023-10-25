import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificaciones'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('notifications')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator(); // Display a loading indicator.
          }
          final notifications = snapshot.data?.docs;
          return ListView.builder(
            itemCount: notifications?.length,
            itemBuilder: (context, index) {
              final notification = notifications?[index];
              final data = notification?.data();

              if (data == null ||
                  !data.containsKey('title') ||
                  !data.containsKey('body')) {
                // Handle the case where the 'title' or 'message' field is missing.
                return const ListTile(
                  title: Text('Missing Data'),
                  subtitle: Text('Notification data is incomplete.'),
                );
              }

              final title = data['title'];
              final message = data['body'];

              // You can format and display the notification data here.
              return Card(
                elevation: 5,
                child: ListTile(
                  title: Text(title),
                  subtitle: Text(message),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
