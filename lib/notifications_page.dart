import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Today',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          _buildNotificationItem(
            title: 'New connection',
            description: 'Miller accepted your friend request',
            time: '2 hours ago',
            icon: Icons.group_add,
            iconColor: Colors.blue,
          ),
          _buildNotificationItem(
            title: 'Message received',
            description: 'You have a new message from Sarah',
            time: '4 hours ago',
            icon: Icons.message,
            iconColor: Colors.green,
          ),
          const SizedBox(height: 25),
          const Text(
            'Yesterday',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          _buildNotificationItem(
            title: 'Friend suggestion',
            description: 'You have 5 new friend suggestions',
            time: '1 day ago',
            icon: Icons.people,
            iconColor: Colors.purple,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem({
    required String title,
    required String description,
    required String time,
    required IconData icon,
    required Color iconColor,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        leading: Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(description),
            const SizedBox(height: 5),
            Text(
              time,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.more_vert, size: 20),
          onPressed: () {},
        ),
      ),
    );
  }
}