
import 'package:flutter/material.dart';
import 'package:wrenchgo/mech_booking_history.dart';
import 'package:wrenchgo/mech_earnings.dart';
import 'package:wrenchgo/mech_profile.dart';
import 'package:wrenchgo/service_request.dart';

class MechanicDashboard extends StatefulWidget {
  const MechanicDashboard({super.key});

  @override
  State<MechanicDashboard> createState() => _MechanicDashboardState();
}

class _MechanicDashboardState extends State<MechanicDashboard> {
  bool isAvailable = true;

  final List<Map<String, dynamic>> quickActions = [
    {
      'title': 'My Bookings',
      'icon': Icons.calendar_month_outlined,
    },
    {
      'title': 'Availability',
      'icon': Icons.access_time_outlined,
    },
    {
      'title': 'Earnings',
      'icon': Icons.account_balance_wallet_outlined,
    },
    {
      'title': 'Reviews',
      'icon': Icons.star_outline,
    },
    {
      'title': 'Settings',
      'icon': Icons.settings_outlined,
    },
  ];

  final List<Map<String, dynamic>> recentBookings = [
    {
      'vehicle': 'Maruti Swift',
      'number': 'AP 25 CB 2635',
      'service': 'Battery Jump Start',
      'time': 'Today, 08:13',
      'status': 'Completed',
      'amount': '₹350.00',
      'icon': Icons.battery_charging_full_outlined,
    },
    {
      'vehicle': 'Pulsar',
      'number': 'AP 27 NB 2635',
      'service': 'Front Tyre Puncture',
      'time': 'Yesterday, 18:36',
      'status': 'Cancelled',
      'amount': '₹150.00',
      'icon': Icons.tire_repair_outlined,
    },
  ];

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void toggleAvailability() {
    setState(() {
      isAvailable = !isAvailable;
    });

    showMessage(
      isAvailable
          ? 'You are now available for bookings.'
          : 'You are now unavailable for bookings.',
    );
  }

  void showBookingDetails(Map<String, dynamic> booking) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(booking['service']),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Vehicle: ${booking['vehicle']}'),
              const SizedBox(height: 8),
              Text('Number: ${booking['number']}'),
              const SizedBox(height: 8),
              Text('Time: ${booking['time']}'),
              const SizedBox(height: 8),
              Text('Status: ${booking['status']}'),
              const SizedBox(height: 8),
              Text('Amount: ${booking['amount']}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF4FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEEF4FF),
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
        title: const Text(
          'Mechanic Dashboard',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showMessage('No new notifications.');
            },
            icon: const Icon(Icons.notifications_none),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _profileCard(),
              const SizedBox(height: 16),
              _statisticsSection(),
              const SizedBox(height: 18),
              _earningsCard(),
              const SizedBox(height: 18),
              _upcomingBooking(),
              const SizedBox(height: 18),
              _quickActions(),
              const SizedBox(height: 18),
              _recentBookings(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _profileCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F5),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFDDE7F5),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 68,
            height: 68,
            decoration: BoxDecoration(
              color: const Color(0xFFD9D7FF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.person,
              size: 38,
              color: Color(0xFF115FCC),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Ravi Kumar',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                const Text(
                  'Professional Mechanic',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: const [
                    Icon(
                      Icons.star,
                      size: 15,
                      color: Colors.orange,
                    ),
                    SizedBox(width: 4),
                    Text(
                      '4.8',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 4),
                    Text(
                      '(120 Reviews)',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              const Text(
                '85%',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 3),
              const Text(
                'Complete rate',
                style: TextStyle(
                  fontSize: 9,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statisticsSection() {
    return Row(
      children: [
        Expanded(
          child: _statCard(
            icon: Icons.calendar_today_outlined,
            title: "Today's Booking",
            value: '5',
            footer: 'View All',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _statCard(
            icon: Icons.check_circle_outline,
            title: 'Completed',
            value: '120',
            footer: 'This month',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _statCard(
            icon: Icons.pending_actions_outlined,
            title: 'Ongoing',
            value: '3',
            footer: 'In Progress',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _statCard(
            icon: Icons.star_outline,
            title: 'Total Reviews',
            value: '230',
            footer: 'View Reviews',
          ),
        ),
      ],
    );
  }

  Widget _statCard({
    required IconData icon,
    required String title,
    required String value,
    required String footer,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 23,
            color: const Color(0xFF115FCC),
          ),
          const SizedBox(height: 7),
          Text(
            title,
            maxLines: 2,
            style: const TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            value,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            footer,
            style: const TextStyle(
              fontSize: 8,
              color: Color(0xFF0786FD),
            ),
          ),
        ],
      ),
    );
  }

  Widget _earningsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE5FFE4),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Earnings (This month)',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '₹26,360',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(
                      Icons.trending_up,
                      size: 14,
                      color: Colors.green,
                    ),
                    SizedBox(width: 4),
                    Text(
                      '16% vs last month',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Icon(
            Icons.account_balance_wallet_outlined,
            size: 45,
            color: Color(0xFF238E08),
          ),
        ],
      ),
    );
  }

  Widget _upcomingBooking() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Upcoming Booking',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD9D7FF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.car_repair_outlined,
                      color: Color(0xFF115FCC),
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Vehicle Not Starting',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Cross roads, Guntur',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Maruti Swift • AP 25 CB 2635',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    '10:30 AM',
                    style: TextStyle(
                      color: Color(0xFF220AF7),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        showMessage('Calling customer...');
                      },
                      icon: const Icon(Icons.call_outlined, size: 17),
                      label: const Text('Call Customer'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        showMessage('Opening customer location...');
                      },
                      icon: const Icon(Icons.location_on_outlined, size: 17),
                      label: const Text('View Location'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _quickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: quickActions.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            crossAxisSpacing: 8,
            childAspectRatio: 0.85,
          ),
          itemBuilder: (context, index) {
            final action = quickActions[index];

            return InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                showMessage('${action['title']} selected.');
              },
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      action['icon'],
                      color: const Color(0xFF115FCC),
                      size: 25,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    action['title'],
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 9,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _recentBookings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'Recent Bookings',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                showMessage('Showing all bookings.');
              },
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 4),
        ...recentBookings.map(
          (booking) => _recentBookingCard(booking),
        ),
      ],
    );
  }

  Widget _recentBookingCard(Map<String, dynamic> booking) {
    final bool completed = booking['status'] == 'Completed';

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      color: Colors.white,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => showBookingDetails(booking),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F0FF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  booking['icon'],
                  color: const Color(0xFF115FCC),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      booking['service'],
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${booking['vehicle']} • ${booking['number']}',
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      booking['time'],
                      style: const TextStyle(
                        fontSize: 9,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    booking['amount'],
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: completed
                          ? Colors.green.withOpacity(0.1)
                          : Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      booking['status'],
                      style: TextStyle(
                        fontSize: 9,
                        color: completed ? Colors.green : Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: 0,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color(0xFF2563EB),
      unselectedItemColor: Colors.black54,
      onTap: (index) {
        if (index == 0) {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>MechanicDashboard()));
        }
        if (index == 1) {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>MechanicBookingHistory()));
        }
        if (index == 2) {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ServiceRequest()));
        }
        if (index == 3) {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>MechanicEarnings()));
        }
        if (index == 4) {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>MechanicProfile()));
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month_outlined),
          label: 'Bookings',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle_outline),
          label: 'New Booking',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance_wallet_outlined),
          label: 'Earnings',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        ),
      ],
    );
  }
}
