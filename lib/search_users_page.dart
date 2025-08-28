import 'package:flutter/material.dart';

class SearchUsersPage extends StatefulWidget {
  const SearchUsersPage({super.key});

  @override
  State<SearchUsersPage> createState() => _SearchUsersPageState();
}

class _SearchUsersPageState extends State<SearchUsersPage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Focus on the search field when the page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_searchFocusNode);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Users'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // This makes the back arrow work
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              focusNode: _searchFocusNode,
              decoration: InputDecoration(
                hintText: 'Search by username or interests...',
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
              autofocus: true, // Automatically focus on this field
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Recent Searches',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: ListView(
                children: [
                  _buildSearchItem(
                    name: 'Miller',
                    mutualInterests: 3,
                    imageUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
                  ),
                  _buildSearchItem(
                    name: 'Sarah',
                    mutualInterests: 2,
                    imageUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
                  ),
                  _buildSearchItem(
                    name: 'Alex',
                    mutualInterests: 4,
                    imageUrl: 'https://randomuser.me/api/portraits/men/22.jpg',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchItem({
    required String name,
    required int mutualInterests,
    required String imageUrl,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(imageUrl),
        ),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('$mutualInterests mutual interests'),
        trailing: IconButton(
          icon: const Icon(Icons.chat, color: Colors.blue),
          onPressed: () {},
        ),
      ),
    );
  }
}