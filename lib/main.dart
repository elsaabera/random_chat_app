import 'package:flutter/material.dart';
import 'discover_page.dart';
import 'friend_requests_page.dart';
import 'search_users_page.dart';
import 'notifications_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Chat App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1; // Start with Friend Requests selected
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> _pages = [
    const DiscoverPage(),
    const FriendRequestsPage(),
    const SearchUsersPage(),
    const NotificationsPage(),
  ];

  final List<String> _pageTitles = [
    'Discover People',
    'Friend Requests',
    'Search Users',
    'Notifications',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Close the drawer if it's open
    if (_scaffoldKey.currentState!.isDrawerOpen) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_pageTitles[_selectedIndex]),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
      ),
      drawer: _buildDrawer(),
      body: Row(
        children: [
          // Sidebar for larger screens
          if (MediaQuery.of(context).size.width >= 1200) _buildDesktopSidebar(),
          // Main content
          Expanded(
            child: _pages[_selectedIndex],
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // User profile header
            _buildUserHeader(),
            const SizedBox(height: 16),
            // Navigation items
            _buildNavItem(Icons.group, 'Friend Requests', 1, '12 pending'),
            _buildNavItem(Icons.notifications, 'Notifications', 3, '4 unread'),
            _buildNavItem(Icons.explore, 'Discoveries', 0, '8 new'),
            const Divider(height: 32, thickness: 1),
            _buildNavItem(Icons.logout, 'Log Out', -1, ''),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopSidebar() {
    return Container(
      width: 280,
      color: Colors.white,
      child: Column(
        children: [
          // User profile header
          _buildUserHeader(),
          const SizedBox(height: 24),
          // Navigation items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                
                _buildDesktopNavItem(Icons.notifications, 'Notifications', 3, '4 unread'),
                _buildDesktopNavItem(Icons.group, 'Friend Requests', 1, '12 pending'),
                _buildDesktopNavItem(Icons.explore, 'Discoveries', 0, '8 new'),
                const Divider(height: 32, thickness: 1),
                _buildDesktopNavItem(Icons.logout, 'Log Out', -1, ''),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Color(0xFFF8F9FA),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage('https://randomuser.me/api/portraits/women/68.jpg'),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Melissa Tung',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Online',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 20),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String title, int index, String subtitle) {
    return ListTile(
      leading: Icon(icon, color: _selectedIndex == index ? Colors.blue : Colors.grey[700]),
      title: Text(title),
      subtitle: subtitle.isNotEmpty ? Text(subtitle) : null,
      selected: _selectedIndex == index,
      selectedTileColor: Colors.blue.withOpacity(0.1),
      onTap: () {
        if (index >= 0) {
          _onItemTapped(index);
        } else {
          // Handle Log Out
          Navigator.of(context).pop();
          // Add your logout logic here
        }
      },
    );
  }

  Widget _buildDesktopNavItem(IconData icon, String title, int index, String subtitle) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _selectedIndex == index ? Colors.blue.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(icon, color: _selectedIndex == index ? Colors.blue : Colors.grey[700]),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: _selectedIndex == index ? FontWeight.bold : FontWeight.normal,
            color: _selectedIndex == index ? Colors.blue : Colors.black,
          ),
        ),
        subtitle: subtitle.isNotEmpty 
            ? Text(
                subtitle,
                style: TextStyle(
                  color: _selectedIndex == index ? Colors.blue : Colors.grey[600],
                ),
              )
            : null,
        onTap: () {
          if (index >= 0) {
            _onItemTapped(index);
          } else {
            // Handle Log Out
            // Add your logout logic here
          }
        },
      ),
    );
  }
}