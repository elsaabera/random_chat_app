import 'package:flutter/material.dart';
import 'search_users_page.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Discover People',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Find and connect with people who share your interests',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF666666),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 20),
            // Search field that shows keyboard when tapped
            TextField(
              decoration: InputDecoration(
                hintText: 'Search by name, interests, or bio...',
                hintStyle: const TextStyle(color: Color(0xFF999999)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: const Color(0xFFF5F5F5),
                prefixIcon: const Icon(Icons.search, color: Color(0xFF666666)),
                contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
              ),
              onTap: () {
                // Navigate to search page when tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchUsersPage()),
                );
              },
            ),
            const SizedBox(height: 24),
            
            // Stats Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _StatItem(count: '36', label: 'Conversations'),
                  _StatItem(count: '4', label: 'Notifications'),
                  _StatItem(count: '4', label: 'Discoveries'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Recommended Users Section - 2 Column Grid
            const Text(
              'Recommended for you',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 0.75,
              children: [
                _buildGridUserCard(
                  name: 'Sarah Miller',
                  mutualInterests: 3,
                  bio: 'Photography, travel, coffee',
                  imageUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
                ),
                _buildGridUserCard(
                  name: 'Alex Johnson',
                  mutualInterests: 2,
                  bio: 'Digital art, gaming',
                  imageUrl: 'https://randomuser.me/api/portraits/men/22.jpg',
                ),
                _buildGridUserCard(
                  name: 'Michael Chen',
                  mutualInterests: 4,
                  bio: 'Food, travel, blogging',
                  imageUrl: 'https://randomuser.me/api/portraits/men/42.jpg',
                ),
                _buildGridUserCard(
                  name: 'Emma Wilson',
                  mutualInterests: 2,
                  bio: 'Music, hiking, photography',
                  imageUrl: 'https://randomuser.me/api/portraits/women/65.jpg',
                ),
              ],
            ),
            
            // Add extra space at the bottom to prevent overflow
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildGridUserCard({
    required String name,
    required int mutualInterests,
    required String bio,
    required String imageUrl,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(imageUrl),
          ),
          const SizedBox(height: 12),
          Text(
            name,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            '$mutualInterests mutual interests',
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF1976D2),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            bio,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF666666),
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2C3E50),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              minimumSize: const Size(120, 36),
            ),
            child: const Text(
              'Connect',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String count;
  final String label;

  const _StatItem({
    required this.count,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1976D2),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF666666),
          ),
        ),
      ],
    );
  }
}