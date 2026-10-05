import 'package:flutter/material.dart';
import 'package:wrenchgo/mechdetails.dart';

class FindMechanic extends StatefulWidget {
  const FindMechanic({super.key});

  @override
  State<FindMechanic> createState() => _FindMechanicState();
}

class _FindMechanicState extends State<FindMechanic> {
  final TextEditingController searchController = TextEditingController();

  String selectedSort = 'Nearest';

  final List<Map<String, dynamic>> mechanics = [
    {
      'name': 'Rahul Kumar',
      'distance': '7.2 km away',
      'rating': '4.8 (120)',
      'status': 'Available',
      'statusColor': Colors.green,
    },
    {
      'name': 'Axar Patel',
      'distance': '8.6 km away',
      'rating': '4.7 (80)',
      'status': 'Busy',
      'statusColor': Colors.red,
    },
    {
      'name': 'Rinku Singh',
      'distance': '5.4 km away',
      'rating': '4.3 (185)',
      'status': 'Available',
      'statusColor': Colors.green,
    },
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF4FF),

      // ================= APP BAR =================

      appBar: AppBar(
        backgroundColor: const Color(0xFFEEF4FF),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Find Mechanic',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // Notification action
            },
            icon: const Icon(
              Icons.notifications_none,
              color: Colors.black,
            ),
          ),
        ],
      ),

      // ================= BODY =================

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ================= SEARCH LOCATION =================

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 23,
                  vertical: 10,
                ),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search Location',
                    hintStyle: const TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 13,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color(0xFF64748B),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        searchController.clear();
                        setState(() {});
                      },
                      icon: const Icon(
                        Icons.clear,
                        color: Color(0xFF64748B),
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xFFE2E8F0),
                      ),
                    ),
                  ),
                ),
              ),

              // ================= CURRENT LOCATION =================

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 23,
                  vertical: 5,
                ),
                child: Container(
                  width: double.infinity,
                  height: 42,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Current location selected',
                          ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.my_location,
                      color: Color(0xFF0068FF),
                      size: 20,
                    ),
                    label: const Text(
                      'Use Current Location',
                      style: TextStyle(
                        color: Color(0xFF0068FF),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // ================= TITLE + SORT =================

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 23,
                ),
                child: Row(
                  children: [
                    const Text(
                      'Nearby Mechanics',
                      style: TextStyle(
                        color: Color(0xFF143927),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const Spacer(),

                    TextButton(
                      onPressed: () {
                        showSortOptions();
                      },
                      child: Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Sort: ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: selectedSort,
                              style: const TextStyle(
                                color: Color(0xFF6C5CE7),
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 5),

              // ================= MECHANIC LIST =================

              ...mechanics.map(
                (mechanic) => _mechanicCard(
                  name: mechanic['name'],
                  distance: mechanic['distance'],
                  rating: mechanic['rating'],
                  status: mechanic['status'],
                  statusColor: mechanic['statusColor'],
                ),
              ),

              const SizedBox(height: 15),

              // ================= LOAD MORE =================

              Center(
                child: TextButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('More mechanics loaded'),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.refresh,
                    color: Color(0xFF0068FF),
                  ),
                  label: const Text(
                    'Load More',
                    style: TextStyle(
                      color: Color(0xFF0068FF),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ================= POPULAR SERVICES =================

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 23),
                child: Text(
                  'Popular Services',
                  style: TextStyle(
                    color: Color(0xFF143927),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 23),
                child: Row(
                  children: [
                    _serviceCard(
                      icon: Icons.build,
                      title: 'Repair',
                    ),
                    const SizedBox(width: 12),
                    _serviceCard(
                      icon: Icons.battery_charging_full,
                      title: 'Battery',
                    ),
                    const SizedBox(width: 12),
                    _serviceCard(
                      icon: Icons.tire_repair,
                      title: 'Tyre',
                    ),
                    const SizedBox(width: 12),
                    _serviceCard(
                      icon: Icons.local_car_wash,
                      title: 'Service',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // MECHANIC CARD
  // ============================================================

  Widget _mechanicCard({
    required String name,
    required String distance,
    required String rating,
    required String status,
    required Color statusColor,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 7,
      ),
      padding: const EdgeInsets.all(10),
      height: 130,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [

          // Mechanic icon
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              color: const Color(0xFFE0EAFF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.person,
              size: 60,
              color: Color(0xFF2563EB),
            ),
          ),

          const SizedBox(width: 15),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      size: 20,
                      color: Colors.orange,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      rating,
                      style: const TextStyle(
                        color: Color(0xFF1F2937),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 5),

                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 20,
                      color: Color(0xFF64748B),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      distance,
                      style: const TextStyle(
                        color: Color(0xFF1F2937),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 5),

                Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // Arrow
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> MechanicDetails()));
              // Open mechanic details
            },
            icon: const Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SERVICE CARD
  // ============================================================

  Widget _serviceCard({
    required IconData icon,
    required String title,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$title service selected'),
            ),
          );
        },
        child: Container(
          height: 79,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(9),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: const Color(0xFF2563EB),
                size: 30,
              ),
              const SizedBox(height: 5),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SORT OPTIONS
  // ============================================================

  void showSortOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Sort Mechanics',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text('Nearest'),
              onTap: () {
                setState(() {
                  selectedSort = 'Nearest';
                });
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.star),
              title: const Text('Highest Rated'),
              onTap: () {
                setState(() {
                  selectedSort = 'Highest Rated';
                });
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.check_circle),
              title: const Text('Available Only'),
              onTap: () {
                setState(() {
                  selectedSort = 'Available';
                });
                Navigator.pop(context);
              },
            ),

            const SizedBox(height: 20),
          ],
        );
      },
    );
  }
}
