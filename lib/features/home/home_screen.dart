
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController =
      TextEditingController();

  String searchQuery = '';
  int selectedTab = 0;

  final categories = const [
    ('Business', Icons.business_center_outlined),
    ('Technology', Icons.computer_outlined),
    ('Career', Icons.work_outline),
    ('Finance', Icons.account_balance_wallet_outlined),
    ('Education', Icons.school_outlined),
    ('Wellness', Icons.favorite_outline),
  ];

  final experts = const [
    (
      'Sarah Johnson',
      'Business Strategy Consultant',
      'Business',
      4.9,
      80,
    ),
    (
      'Michael Chen',
      'Technology & Cloud Advisor',
      'Technology',
      4.8,
      65,
    ),
    (
      'Emma Wilson',
      'Career Development Coach',
      'Career',
      5.0,
      55,
    ),
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredExperts = experts.where((expert) {
      final query = searchQuery.toLowerCase();

      return expert.$1.toLowerCase().contains(query) ||
          expert.$2.toLowerCase().contains(query) ||
          expert.$3.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Expert Connect',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Notifications coming soon'),
                ),
              );
            },
            icon: const Icon(Icons.notifications_none),
          ),
        ],
      ),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'Find Your Expert',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Connect with professionals who can help you.',
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 22),

            // Search
            TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() => searchQuery = value);
              },
              decoration: InputDecoration(
                hintText: 'Search experts or specialties',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 28),

            const Text(
              'Explore Categories',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: categories.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.1,
              ),
              itemBuilder: (context, index) {
                final category = categories[index];

                return InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    searchController.text = category.$1;
                    setState(() {
                      searchQuery = category.$1;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          category.$2,
                          size: 30,
                          color: const Color(0xFF146C70),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          category.$1,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 28),

            const Text(
              'Featured Experts',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 14),

            if (filteredExperts.isEmpty)
              const Padding(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Text('No experts found'),
                ),
              ),

            ...filteredExperts.map((expert) {
              return Card(
                color: Colors.white,
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  leading: const CircleAvatar(
                    radius: 28,
                    backgroundColor: Color(0xFFE0F2F1),
                    child: Icon(
                      Icons.person,
                      color: Color(0xFF146C70),
                      size: 30,
                    ),
                  ),
                  title: Text(
                    expert.$1,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    '${expert.$2}\n'
                    '⭐ ${expert.$4}  •  A\$${expert.$5}/session',
                  ),
                  isThreeLine: true,
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '${expert.$1} profile coming next',
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedTab,
        onDestinationSelected: (index) {
          if (index == 0) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('This section is coming soon'),
            ),
          );
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Bookings',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Messages',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
