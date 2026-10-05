
import 'package:flutter/material.dart';
import 'package:wrenchgo/mech_dash.dart';
import 'package:wrenchgo/mech_earnings.dart';
import 'package:wrenchgo/mech_profile.dart';
import 'package:wrenchgo/service_request.dart';

class MechanicBookingHistory extends StatefulWidget {
  const MechanicBookingHistory({super.key});

  @override
  State<MechanicBookingHistory> createState() =>
      _MechanicBookingHistoryState();
}

class _MechanicBookingHistoryState extends State<MechanicBookingHistory> {
  int selectedFilter = 0;

  final List<Map<String, dynamic>> bookings = [
    {
      'id': '#WG12345',
      'vehicle': 'Maruti Swift',
      'number': 'AP28 AB 1234',
      'location': 'MVP Colony, Vizag',
      'date': '12 May 2026',
      'time': '10:35 AM',
      'status': 'Completed',
    },
    {
      'id': '#WG12344',
      'vehicle': 'Activa 6G',
      'number': 'AP28 EF 1144',
      'location': 'MVP Colony, Vizag',
      'date': '12 May 2026',
      'time': '10:35 AM',
      'status': 'Completed',
    },
    {
      'id': '#WG12343',
      'vehicle': 'Honda City',
      'number': 'AP28 BG 2222',
      'location': 'MG Road, Vijayawada',
      'date': '12 May 2026',
      'time': '10:35 AM',
      'status': 'Completed',
    },
    {
      'id': '#WG12342',
      'vehicle': 'Pulsar 150',
      'number': 'AP32 GH 6897',
      'location': 'MVP Colony, Vizag',
      'date': '12 May 2026',
      'time': '10:35 AM',
      'status': 'Ongoing',
    },
    {
      'id': '#WG12341',
      'vehicle': 'Ola EV',
      'number': 'AP40 CC 0001',
      'location': 'MVP Colony, Vizag',
      'date': '12 May 2026',
      'time': '10:35 AM',
      'status': 'Cancelled',
    },
  ];

  final List<String> filters = [
    'All',
    'Completed',
    'Ongoing',
    'Cancelled',
  ];

  List<Map<String, dynamic>> get filteredBookings {
    if (selectedFilter == 0) {
      return bookings;
    }

    final status = filters[selectedFilter];

    return bookings
        .where((booking) => booking['status'] == status)
        .toList();
  }

  void showBookingDetails(Map<String, dynamic> booking) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(booking['id']),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Vehicle: ${booking['vehicle']}'),
              const SizedBox(height: 8),
              Text('Number: ${booking['number']}'),
              const SizedBox(height: 8),
              Text('Location: ${booking['location']}'),
              const SizedBox(height: 8),
              Text('Date: ${booking['date']}'),
              const SizedBox(height: 8),
              Text('Time: ${booking['time']}'),
              const SizedBox(height: 8),
              Text('Status: ${booking['status']}'),
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

  void changeFilter(int index) {
    setState(() {
      selectedFilter = index;
    });
  }

  Color statusColor(String status) {
    switch (status) {
      case 'Completed':
        return Colors.green;
      case 'Ongoing':
        return Colors.orange;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF4FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEEF4FF),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'Booking History',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Notifications opened.'),
                ),
              );
            },
            icon: const Icon(Icons.notifications_none),
          ),
        ],
      ),
      body: Column(
        children: [
          _summarySection(),
          _searchBar(),
          _filterTabs(),
          const Divider(height: 1),

          Expanded(
            child: filteredBookings.isEmpty
                ? _emptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredBookings.length,
                    itemBuilder: (context, index) {
                      return _bookingCard(filteredBookings[index]);
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _summarySection() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: _summaryItem(
              icon: Icons.check_circle_outline,
              title: 'Completed',
              value: '128',
              color: Colors.green,
            ),
          ),
          _verticalDivider(),
          Expanded(
            child: _summaryItem(
              icon: Icons.pending_actions_outlined,
              title: 'Ongoing',
              value: '8',
              color: Colors.orange,
            ),
          ),
          _verticalDivider(),
          Expanded(
            child: _summaryItem(
              icon: Icons.cancel_outlined,
              title: 'Cancelled',
              value: '12',
              color: Colors.red,
            ),
          ),
          _verticalDivider(),
          Expanded(
            child: _summaryItem(
              icon: Icons.calendar_month_outlined,
              title: 'Total Bookings',
              value: '148',
              color: const Color(0xFF220AF7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryItem({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color: color,
          size: 25,
        ),
        const SizedBox(height: 6),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _verticalDivider() {
    return Container(
      height: 65,
      width: 1,
      color: Colors.grey.shade300,
    );
  }

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4,
      ),
      child: TextField(
        onChanged: (value) {
          // Search can be connected to Firebase later.
        },
        decoration: InputDecoration(
          hintText: 'Search by booking ID / Customer',
          hintStyle: const TextStyle(
            fontSize: 12,
          ),
          prefixIcon: const Icon(
            Icons.search,
            size: 20,
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _filterTabs() {
    return SizedBox(
      height: 55,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final selected = selectedFilter == index;

          Color color;

          switch (index) {
            case 1:
              color = Colors.green;
              break;
            case 2:
              color = Colors.orange;
              break;
            case 3:
              color = Colors.red;
              break;
            default:
              color = const Color(0xFF2563EB);
          }

          return GestureDetector(
            onTap: () => changeFilter(index),
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 8,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              decoration: BoxDecoration(
                color: selected
                    ? color.withOpacity(0.10)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Text(
                filters[index],
                style: TextStyle(
                  color: color,
                  fontSize: 14,
                  fontWeight: selected
                      ? FontWeight.w700
                      : FontWeight.w600,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _bookingCard(Map<String, dynamic> booking) {
    final status = booking['status'] as String;
    final color = statusColor(status);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      color: Colors.white,
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
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  _vehicleIcon(booking['vehicle']),
                  color: color,
                  size: 30,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      booking['id'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      booking['vehicle'],
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      booking['number'],
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      booking['location'],
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${booking['date']} • ${booking['time']}',
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 6),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: color,
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _vehicleIcon(String vehicle) {
    if (vehicle.toLowerCase().contains('activa') ||
        vehicle.toLowerCase().contains('pulsar')) {
      return Icons.two_wheeler_outlined;
    }

    if (vehicle.toLowerCase().contains('ola')) {
      return Icons.electric_scooter_outlined;
    }

    return Icons.directions_car_outlined;
  }

  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history_outlined,
            size: 65,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 12),
          const Text(
            'No bookings found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
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
