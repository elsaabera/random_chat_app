import 'package:flutter/material.dart';
import 'search_users_page.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  // All recommendations
  final List<Map<String, dynamic>> _allRecommendations = [
    {
      'name': 'Sarah Miller',
      'mutualInterests': 3,
      'bio': 'Photography, travel, coffee',
      'imageUrl': 'https://randomuser.me/api/portraits/women/44.jpg',
    },
    {
      'name': 'Alex Johnson',
      'mutualInterests': 2,
      'bio': 'Digital art, gaming',
      'imageUrl': 'https://randomuser.me/api/portraits/men/22.jpg',
    },
    {
      'name': 'Michael Chen',
      'mutualInterests': 4,
      'bio': 'Food, travel, blogging',
      'imageUrl': 'https://randomuser.me/api/portraits/men/42.jpg',
    },
    {
      'name': 'Emma Wilson',
      'mutualInterests': 2,
      'bio': 'Music, hiking',
      'imageUrl': 'https://randomuser.me/api/portraits/women/65.jpg',
    },
    {
      'name': 'David Kim',
      'mutualInterests': 3,
      'bio': 'Tech, startups, fitness',
      'imageUrl': 'https://randomuser.me/api/portraits/men/32.jpg',
    },
    {
      'name': 'Lisa Taylor',
      'mutualInterests': 1,
      'bio': 'Art, design, fashion',
      'imageUrl': 'https://randomuser.me/api/portraits/women/28.jpg',
    },
    {
      'name': 'James Wilson',
      'mutualInterests': 4,
      'bio': 'Sports, cooking, movies',
      'imageUrl': 'https://randomuser.me/api/portraits/men/45.jpg',
    },
    {
      'name': 'Sophia Martinez',
      'mutualInterests': 2,
      'bio': 'Reading, yoga, nature',
      'imageUrl': 'https://randomuser.me/api/portraits/women/33.jpg',
    },
    {
      'name': 'Robert Brown',
      'mutualInterests': 3,
      'bio': 'Technology, hiking, photography',
      'imageUrl': 'https://randomuser.me/api/portraits/men/29.jpg',
    },
    {
      'name': 'Olivia Davis',
      'mutualInterests': 2,
      'bio': 'Painting, music, travel',
      'imageUrl': 'https://randomuser.me/api/portraits/women/52.jpg',
    },
    {
      'name': 'William Johnson',
      'mutualInterests': 4,
      'bio': 'Coding, basketball, music',
      'imageUrl': 'https://randomuser.me/api/portraits/men/56.jpg',
    },
    {
      'name': 'Isabella Garcia',
      'mutualInterests': 3,
      'bio': 'Dancing, cooking, travel',
      'imageUrl': 'https://randomuser.me/api/portraits/women/57.jpg',
    },
  ];

  int _currentPage = 1;
  final int _itemsPerPage = 4;
  bool _isLoading = false;

  List<Map<String, dynamic>> get _currentPageRecommendations {
    final startIndex = (_currentPage - 1) * _itemsPerPage;
    final endIndex = startIndex + _itemsPerPage;
    
    if (startIndex >= _allRecommendations.length) {
      return [];
    }
    
    if (endIndex > _allRecommendations.length) {
      return _allRecommendations.sublist(startIndex);
    }
    
    return _allRecommendations.sublist(startIndex, endIndex);
  }

  bool get _hasNextPage {
    return _currentPage * _itemsPerPage < _allRecommendations.length;
  }

  Future<void> _loadNextPage() async {
    if (_isLoading || !_hasNextPage) return;

    setState(() {
      _isLoading = true;
    });

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      _currentPage++;
      _isLoading = false;
    });
  }

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
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 40.0),
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
              children: _currentPageRecommendations.map((user) {
                return _buildGridUserCard(
                  name: user['name'],
                  mutualInterests: user['mutualInterests'],
                  bio: user['bio'],
                  imageUrl: user['imageUrl'],
                );
              }).toList(),
            ),
            
            // Loading indicator or "See More" button
            if (_isLoading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFF1976D2),
                  ),
                ),
              )
            else if (_hasNextPage)
              Container(
                margin: const EdgeInsets.only(top: 16, bottom: 24),
                child: Center(
                  child: ElevatedButton(
                    onPressed: _loadNextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF1976D2),
                      side: const BorderSide(color: Color(0xFF1976D2)),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'See More',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              )
            else if (_currentPage > 1)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Text(
                    'No more recommendations',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                    ),
                  ),
                ),
              ),
            
            // Add extra space at the bottom to prevent overflow
            const SizedBox(height: 30),
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