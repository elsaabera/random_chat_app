import 'package:flutter/material.dart';

class FriendRequestsPage extends StatelessWidget {
  const FriendRequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Friend Requests'),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Pending Requests',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          _buildRequestItem(
            name: 'Emma Thompson',
            mutualFriends: 4,
            imageUrl: 'https://randomuser.me/api/portraits/women/65.jpg',
          ),
          _buildRequestItem(
            name: 'Michael Chen',
            mutualFriends: 2,
            imageUrl: 'https://randomuser.me/api/portraits/men/42.jpg',
          ),
          const SizedBox(height: 25),
          const Text(
            'Suggested Friends',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          _buildSuggestionItem(
            name: 'David Wilson',
            mutualInterests: 5,
            imageUrl: 'https://randomuser.me/api/portraits/men/72.jpg',
          ),
        ],
      ),
    );
  }

  Widget _buildRequestItem({
    required String name,
    required int mutualFriends,
    required String imageUrl,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(imageUrl),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '$mutualFriends mutual friends',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Decline'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Accept'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestionItem({
    required String name,
    required int mutualInterests,
    required String imageUrl,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(imageUrl),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '$mutualInterests mutual interests',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Send Request'),
            ),
          ],
        ),
      ),
    );
  }
}