
import 'package:flutter/material.dart';
import 'package:wrenchgo/manage_booking.dart';
import 'package:wrenchgo/manage_mechanics.dart';
import 'package:wrenchgo/manage_users.dart';
import 'package:wrenchgo/manage_verification.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int selectedIndex = 0;

  final List<Map<String, dynamic>> recentBookings = [
    {
      'id': '#WQ70921',
      'customer': 'Hari',
      'service': 'Engine Repair',
      'date': '08 Aug 2026, 10:41 AM',
      'status': 'Confirmed',
    },
    {
      'id': '#WQ80967',
      'customer': 'Harsha',
      'service': 'Tyre Repair',
      'date': '08 Aug 2026, 11:00 AM',
      'status': 'Pending',
    },
  ];

  final List<int> bookingData = [
    65,
    30,
    50,
    38,
    70,
    25,
    55,
    30,
    60,
    42,
    72,
    50,
  ];

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _selectNavigation(int index) {
    setState(() {
      selectedIndex = index;
    });
if (index==0){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard()));
    }
    if (index==1){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ManageBooking()));
    }
    if (index==2){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ManageMechanics()));
    }
    if (index==3){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ManageUsers()));
    }
    if (index==4){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ManageVerification()));
    }
  }

  void _viewAllBookings() {
    _showMessage('Opening all bookings');
  }

  void _showBookingDetails(Map<String, dynamic> booking) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(booking['id']),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _dialogRow('Customer', booking['customer']),
              _dialogRow('Service', booking['service']),
              _dialogRow('Date', booking['date']),
              _dialogRow('Status', booking['status']),
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

  Widget _dialogRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 75,
            child: Text(
              '$title:',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF4FF),
      body: SafeArea(
        child: Column(
          children: [
            _header(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _greeting(),
                    const SizedBox(height: 20),
                    _statisticsGrid(),
                    const SizedBox(height: 25),
                    _recentBookingsSection(),
                    const SizedBox(height: 25),
                    _bookingOverview(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _header() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
      decoration: const BoxDecoration(
        color: Color(0xFF0091FF),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.build_circle,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Wrench Go',
                  style: TextStyle(
                    color: Color(0xFF1F2937),
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Admin Dashboard',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              _showMessage('Notifications opened');
            },
            icon: const Icon(
              Icons.notifications_outlined,
              color: Colors.white,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }

  Widget _greeting() {
    return const Text(
      'Good morning, Admin',
      style: TextStyle(
        color: Color(0xFF1F2937),
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _statisticsGrid() {
    final statistics = [
      {
        'title': 'Total Users',
        'value': '2,582',
        'percentage': '12.41%',
        'icon': Icons.people_outline,
      },
      {
        'title': 'Total Mechanics',
        'value': '184',
        'percentage': '9.27%',
        'icon': Icons.engineering_outlined,
      },
      {
        'title': 'Total Bookings',
        'value': '6,842',
        'percentage': '18.12%',
        'icon': Icons.calendar_month_outlined,
      },
      {
        'title': 'Total Revenue',
        'value': '₹8,42,560',
        'percentage': '19.87%',
        'icon': Icons.currency_rupee,
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: statistics.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.8,
      ),
      itemBuilder: (context, index) {
        final item = statistics[index];

        return _statCard(
          title: item['title'] as String,
          value: item['value'] as String,
          percentage: item['percentage'] as String,
          icon: item['icon'] as IconData,
        );
      },
    );
  }

  Widget _statCard({
    required String title,
    required String value,
    required String percentage,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 24,
                color: const Color(0xFF2563EB),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 3),
          Row(
            children: [
              const Icon(
                Icons.arrow_upward,
                size: 12,
                color: Colors.green,
              ),
              Text(
                percentage,
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _recentBookingsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recent Bookings',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextButton(
              onPressed: _viewAllBookings,
              child: const Text(
                'View all',
                style: TextStyle(
                  color: Color(0xFF2563EB),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        ...recentBookings.map(
          (booking) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _bookingCard(booking),
          ),
        ),
      ],
    );
  }

  Widget _bookingCard(Map<String, dynamic> booking) {
    final bool isPending = booking['status'] == 'Pending';

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => _showBookingDetails(booking),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFE2E8F0),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: const Color(0xFFEEF4FF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                booking['service'] == 'Engine Repair'
                    ? Icons.car_repair
                    : Icons.tire_repair,
                color: const Color(0xFF2563EB),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${booking['id']}   ${booking['customer']}',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${booking['service']} • ${booking['date']}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: isPending
                    ? const Color(0xFFE3AF6B)
                    : const Color(0xFFD9FBE0),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                booking['status'],
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bookingOverview() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Bookings Overview',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 180,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _yAxisLabels(),
                const SizedBox(width: 10),
                Expanded(
                  child: _barChart(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _xAxisLabels(),
        ],
      ),
    );
  }

  Widget _yAxisLabels() {
    return SizedBox(
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text('100', style: TextStyle(fontSize: 9)),
          Text('80', style: TextStyle(fontSize: 9)),
          Text('60', style: TextStyle(fontSize: 9)),
          Text('40', style: TextStyle(fontSize: 9)),
          Text('20', style: TextStyle(fontSize: 9)),
          Text('0', style: TextStyle(fontSize: 9)),
        ],
      ),
    );
  }

  Widget _barChart() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final barWidth = constraints.maxWidth / bookingData.length;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: bookingData.map((value) {
            return SizedBox(
              width: barWidth,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: value * 1.35,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6F86FC),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(4),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _xAxisLabels() {
    const labels = [
      '2 Aug',
      '4 Aug',
      '6 Aug',
      '8 Aug',
      '10 Aug',
      '12 Aug',
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: labels
          .map(
            (label) => Text(
              label,
              style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _bottomNavigationBar() {
    final items = [
      {
        'icon': Icons.dashboard_outlined,
        'label': 'Dashboard',
      },
      {
        'icon': Icons.calendar_month_outlined,
        'label': 'Bookings',
      },
      {
        'icon': Icons.engineering_outlined,
        'label': 'Mechanics',
      },
      {
        'icon': Icons.people_outline,
        'label': 'Users',
      },
      {
        'icon': Icons.more_horiz,
        'label': 'More',
      },
    ];

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xFFE2E8F0),
          ),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: List.generate(
            items.length,
            (index) {
              final selected = selectedIndex == index;

              return Expanded(
                child: InkWell(
                  onTap: () => _selectNavigation(index),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          items[index]['icon'] as IconData,
                          size: 25,
                          color: selected
                              ? const Color(0xFF2563EB)
                              : Colors.black,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          items[index]['label'] as String,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: selected
                                ? const Color(0xFF2563EB)
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
