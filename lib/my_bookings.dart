
import 'package:flutter/material.dart';

class MyBookings extends StatefulWidget {
  const MyBookings({super.key});

  @override
  State<MyBookings> createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
  int selectedTab = 0;

  final List<Map<String, dynamic>> bookings = [
    {
      'mechanic': 'Ravi Mechanic',
      'service': 'Engine Repair',
      'date': '11 July 2026 - 10:30 AM',
      'amount': '₹450.00',
      'status': 'Confirmed',
      'icon': Icons.build_circle_outlined,
    },
    {
      'mechanic': 'Axar Patel',
      'service': 'Battery died',
      'date': '24 July 2026 - 9:32 AM',
      'amount': '₹750.00',
      'status': 'Pending',
      'icon': Icons.battery_alert_outlined,
    },
    {
      'mechanic': 'Shivang Kumar',
      'service': 'Tyre puncture',
      'date': '1 Aug 2026 - 5:46 PM',
      'amount': '₹150.00',
      'status': 'Cancelled',
      'icon': Icons.tire_repair_outlined,
    },
    {
      'mechanic': 'Siraj Kumar',
      'service': 'Engine Repair',
      'date': '1 Aug 2026 - 5:56 PM',
      'amount': '₹750.00',
      'status': 'Cancelled',
      'icon': Icons.car_repair_outlined,
    },
  ];

  List<Map<String, dynamic>> get filteredBookings {
    if (selectedTab == 0) {
      return bookings;
    }

    if (selectedTab == 1) {
      return bookings
          .where(
            (booking) =>
                booking['status'] == 'Confirmed' ||
                booking['status'] == 'Pending',
          )
          .toList();
    }

    if (selectedTab == 2) {
      return bookings
          .where((booking) => booking['status'] == 'Completed')
          .toList();
    }

    return bookings
        .where((booking) => booking['status'] == 'Cancelled')
        .toList();
  }

  void changeTab(int index) {
    setState(() {
      selectedTab = index;
    });
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
              Text('Mechanic: ${booking['mechanic']}'),
              const SizedBox(height: 8),
              Text('Date: ${booking['date']}'),
              const SizedBox(height: 8),
              Text('Amount: ${booking['amount']}'),
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

  Color getStatusColor(String status) {
    switch (status) {
      case 'Confirmed':
        return Colors.green;
      case 'Pending':
        return Colors.orange;
      case 'Completed':
        return Colors.blue;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.grey;
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
          'My Bookings',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildTabs(),
          const Divider(height: 1),

          Expanded(
            child: filteredBookings.isEmpty
                ? _buildEmptyState()
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
    );
  }

  Widget _buildTabs() {
    const tabs = [
      'All',
      'Upcoming',
      'Completed',
      'Cancel',
    ];

    return SizedBox(
      height: 55,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        itemBuilder: (context, index) {
          final isSelected = selectedTab == index;

          return GestureDetector(
            onTap: () => changeTab(index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    tabs[index],
                    style: TextStyle(
                      color: isSelected
                          ? const Color(0xFF0788F5)
                          : const Color(0xFF1E293B),
                      fontSize: 15,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 6),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 3,
                    width: isSelected ? 35 : 0,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0788F5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _bookingCard(Map<String, dynamic> booking) {
    final status = booking['status'] as String;
    final statusColor = getStatusColor(status);

    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 1,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => showBookingDetails(booking),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F0FF),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  booking['icon'],
                  size: 36,
                  color: const Color(0xFF115FCC),
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            booking['mechanic'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          booking['amount'],
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 5),

                    Text(
                      booking['service'],
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      booking['date'],
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 9),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.10),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.event_busy_outlined,
              size: 70,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            const Text(
              'No bookings found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'You do not have any bookings in this category.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
