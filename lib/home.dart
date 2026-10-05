
import 'package:flutter/material.dart';
import 'package:wrenchgo/find_mech.dart';
import 'package:wrenchgo/mechdetails.dart';
import 'package:wrenchgo/my_bookings.dart';
import 'package:wrenchgo/profile.dart';
import 'package:wrenchgo/services.dart';
import 'package:wrenchgo/trackmech.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;

  void selectBottomItem(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF4FF),

      // ================= BODY =================

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ================= HEADER =================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                child: Row(
                  children: [

                    // Home icon
                    Container(
                      width: 42,
                      height: 42,
                      decoration: const BoxDecoration(
                        color: Color(0xFF1D4ED8),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.home,
                        color: Colors.white,
                        size: 23,
                      ),
                    ),

                    const SizedBox(width: 10),

                    const Text(
                      'Home',
                      style: TextStyle(
                        color: Color(0xFF1D4ED8),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const Spacer(),

                    // Notification
                    IconButton(
                      onPressed: () {
                        // Notification action
                      },
                      icon: const Icon(
                        Icons.notifications_none,
                        color: Color(0xFF1F2937),
                      ),
                    ),

                    // Profile
                    IconButton(
                      onPressed: () {
                        Navigator.push(context, 
                        MaterialPageRoute(builder: (context)=> Profile()));
                        
                        // Profile action
                      },
                      icon: const Icon(
                        Icons.person_outline,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                  ],
                ),
              ),

              const Divider(
                height: 1,
                color: Color(0xFFE2E8F0),
              ),

              // ================= GREETING =================

              const Padding(
                padding: EdgeInsets.fromLTRB(21, 12, 21, 0),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Hello, Wrench Go\n',
                        style: TextStyle(
                          color: Color(0xFF1F2937),
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: 'Need roadside assistance?',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // ================= SEARCH =================

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search mechanic, service...',
                    hintStyle: const TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 13,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color(0xFF64748B),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xFFE2E8F0),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xFFE2E8F0),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // ================= QUICK ACTIONS TITLE =================

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: [
                    Text(
                      'Quick Actions',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'See all',
                      style: TextStyle(
                        color: Color(0xFF2563EB),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              // ================= QUICK ACTION CARDS =================

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [

                    Expanded(
                      child: _quickActionCard(
                        icon: Icons.location_on,
                        title: 'Find Mechanic',
                        subtitle: 'Near you',
                        onTap: () {
                          Navigator.push(
                          context, MaterialPageRoute(builder: (context)=> FindMechanic()));
                          // Find mechanic
                        },
                      ),
                    ),

                    const SizedBox(width: 18),

                    Expanded(
                      child: _quickActionCard(
                        icon: Icons.build,
                        title: 'Services',
                        subtitle: 'We provide',
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>UserServices()));
                          // Services
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [

                    Expanded(
                      child: _quickActionCard(
                        icon: Icons.location_searching,
                        title: 'Track Mechanic',
                        subtitle: 'Live tracking',
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>TrackMechanic()));
                          // Track mechanic
                        },
                      ),
                    ),

                    const SizedBox(width: 18),

                    Expanded(
                      child: _quickActionCard(
                        icon: Icons.calendar_month,
                        title: 'My Bookings',
                        subtitle: 'View bookings',
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>MyBookings()));
                          // My bookings
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // ================= NEARBY MECHANICS =================

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    const Text(
                      'Nearby Mechanics',
                      style: TextStyle(
                        color: Color(0xFF111111),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const Spacer(),

                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>FindMechanic()));
                        // View all mechanics
                      },
                      child: const Text(
                        'View all',
                        style: TextStyle(
                          color: Color(0xFF2563EB),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // ================= MECHANIC 1 =================

              _mechanicCard(
                name: 'Rahul Kumar',
                distance: '7.2 km away',
                rating: '4.8 (120)',
                icon: Icons.person,
              ),

              const SizedBox(height: 15),

              // ================= MECHANIC 2 =================

              _mechanicCard(
                name: 'Suresh Yadav',
                distance: '4.2 km away',
                rating: '4.5 (98)',
                icon: Icons.person,
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),

      // ================= BOTTOM NAVIGATION =================

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
    setState(() {
      selectedIndex = index;
    });

    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const FindMechanic(),
        ),
      );
    }
    if (index==2){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>MyBookings()));
    }
    if (index==3){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));
    }
  },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF2563EB),
        unselectedItemColor: const Color(0xFF64748B),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Bookings',

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  // ============================================================
  // QUICK ACTION CARD
  // ============================================================

  Widget _quickActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [

            Container(
              width: 52,
              height: 46,
              decoration: const BoxDecoration(
                color: Color(0xFFE0EAFF),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: const Color(0xFF2563EB),
                size: 27,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF1F2937),
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 2),

            Text(
              subtitle,
              style: const TextStyle(
                color: Color(0xFF64748B),
                fontSize: 12,
              ),
            ),
          ],
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
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 23),
      padding: const EdgeInsets.all(10),
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),
      child: Row(
        children: [

          // Mechanic icon
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: const Color(0xFFE0EAFF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              size: 50,
              color: const Color(0xFF2563EB),
            ),
          ),

          const SizedBox(width: 15),

          // Mechanic details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 3),

                const Text(
                  'Expert Mechanic',
                  style: TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 18,
                      color: Color(0xFF64748B),
                    ),
                    const SizedBox(width: 3),
                    Text(
                      distance,
                      style: const TextStyle(
                        color: Color(0xFF1F2937),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      size: 18,
                      color: Colors.orange,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      rating,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Book button
          ElevatedButton(
            onPressed: () {
              // Booking action
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2563EB),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Book Now',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
