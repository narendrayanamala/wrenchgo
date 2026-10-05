import 'package:flutter/material.dart';
import 'package:wrenchgo/manage_booking.dart';
import 'package:wrenchgo/manage_mechanics.dart';
import 'package:wrenchgo/manage_users.dart';
import 'package:wrenchgo/manage_verification.dart';

class ReportAndAnalytics extends StatefulWidget {
  const ReportAndAnalytics({super.key});

  @override
  State<ReportAndAnalytics> createState() => _ReportAndAnalyticsState();
}

class _ReportAndAnalyticsState extends State<ReportAndAnalytics> {
  String selectedPeriod = 'This Month';
  int selectedIndex = 0;

  final List<String> periods = [
    'This Month',
    'Last Month',
    'Last 3 Months',
    'This Year',
  ];

  final List<Map<String, dynamic>> statistics = [
    {
      'title': 'Total Booking',
      'value': '1,248',
      'change': '18.6%',
      'icon': Icons.calendar_month_outlined,
      'positive': true,
    },
    {
      'title': 'Completed',
      'value': '892',
      'change': '15.2%',
      'icon': Icons.check_circle_outline,
      'positive': true,
    },
    {
      'title': 'Cancelled',
      'value': '156',
      'change': '7.3%',
      'icon': Icons.cancel_outlined,
      'positive': false,
    },
    {
      'title': 'Total Users',
      'value': '2,356',
      'change': '20.4%',
      'icon': Icons.people_outline,
      'positive': true,
    },
    {
      'title': 'Total Mechanics',
      'value': '186',
      'change': '8.1%',
      'icon': Icons.engineering_outlined,
      'positive': true,
    },
    {
      'title': 'Total Revenue',
      'value': '2,85,600',
      'change': '22.7%',
      'icon': Icons.currency_rupee,
      'positive': true,
    },
  ];

  final List<Map<String, dynamic>> services = [
    {
      'name': 'Engine Repair',
      'count': '324',
      'percentage': '25.9%',
      'icon': Icons.car_repair,
    },
    {
      'name': 'Oil Change',
      'count': '268',
      'percentage': '21.4%',
      'icon': Icons.oil_barrel_outlined,
    },
    {
      'name': 'Tyre Service',
      'count': '198',
      'percentage': '15.8%',
      'icon': Icons.tire_repair,
    },
    {
      'name': 'General Service',
      'count': '104',
      'percentage': '8.3%',
      'icon': Icons.build_outlined,
    },
  ];

  final List<Map<String, String>> recentActivities = [
    {
      'title': 'Booking #WG1268 completed',
      'subtitle': 'BY Ravi Mechanic',
      'time': '5 min ago',
    },
    {
      'title': 'Booking #WG1257 completed',
      'subtitle': 'Suresh.kumar@gmail.com',
      'time': '25 min ago',
    },
    {
      'title': 'Booking #WG1258 completed',
      'subtitle': 'Speed Auto Work',
      'time': '1 hour ago',
    },
  ];

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _selectPeriod(String period) {
    setState(() {
      selectedPeriod = period;
    });

    _showMessage('Showing $period data');
  }

  void _showPeriodMenu() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Select Period',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ...periods.map(
                (period) => ListTile(
                  leading: Icon(
                    period == selectedPeriod
                        ? Icons.radio_button_checked
                        : Icons.radio_button_off,
                    color: const Color(0xFF2563EB),
                  ),
                  title: Text(period),
                  onTap: () {
                    Navigator.pop(context);
                    _selectPeriod(period);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onBottomNavigationTap(int index) {
    setState(() {
      selectedIndex = index;
    });

  

    if (index==0){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ReportAndAnalytics()));
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
                padding: const EdgeInsets.fromLTRB(12, 16, 12, 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _reportHeader(),
                    const SizedBox(height: 16),
                    _statisticsGrid(),
                    const SizedBox(height: 18),
                    _bookingStatistics(),
                    const SizedBox(height: 18),
                    _mostRequestedServices(),
                    const SizedBox(height: 18),
                    _recentActivity(),
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
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 14,
      ),
      child: const Center(
        child: Text(
          'Report and Analytics',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _reportHeader() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF3E6DED),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFBBB4B4),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.analytics_outlined,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Reports Overview',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Track performance and manage your platform',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: _showPeriodMenu,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF38478A),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Text(
                    selectedPeriod,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statisticsGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: statistics.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1.25,
      ),
      itemBuilder: (context, index) {
        final item = statistics[index];

        return _statCard(
          title: item['title'],
          value: item['value'],
          change: item['change'],
          icon: item['icon'],
          positive: item['positive'],
        );
      },
    );
  }

  Widget _statCard({
    required String title,
    required String value,
    required String change,
    required IconData icon,
    required bool positive,
  }) {
    return Container(
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 21,
            color: const Color(0xFF2563EB),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Icon(
                positive ? Icons.arrow_upward : Icons.arrow_downward,
                size: 10,
                color: positive ? Colors.green : Colors.red,
              ),
              Text(
                change,
                style: TextStyle(
                  fontSize: 9,
                  color: positive ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bookingStatistics() {
    final values = [150, 175, 210, 145, 190, 220];

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE1C9C9),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Booking Statistics',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFFD7CCCC),
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Text(
                  'Daily',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 190,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _chartYAxis(),
                const SizedBox(width: 8),
                Expanded(
                  child: _lineChart(values),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          _chartXAxis(),
        ],
      ),
    );
  }

  Widget _chartYAxis() {
    return SizedBox(
      height: 165,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text('250', style: TextStyle(fontSize: 9)),
          Text('200', style: TextStyle(fontSize: 9)),
          Text('150', style: TextStyle(fontSize: 9)),
          Text('100', style: TextStyle(fontSize: 9)),
          Text('50', style: TextStyle(fontSize: 9)),
          Text('0', style: TextStyle(fontSize: 9)),
        ],
      ),
    );
  }

  Widget _lineChart(List<int> values) {
    return CustomPaint(
      painter: BookingChartPainter(values),
      child: const SizedBox.expand(),
    );
  }

  Widget _chartXAxis() {
    const labels = [
      '1 May',
      '5 May',
      '10 May',
      '15 May',
      '20 May',
      '25 May',
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: labels
          .map(
            (label) => Text(
              label,
              style: const TextStyle(
                fontSize: 9,
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _mostRequestedServices() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Most Requested Services',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextButton(
                onPressed: () {
                  _showMessage('Opening all services');
                },
                child: const Text(
                  'View All',
                  style: TextStyle(
                    color: Color(0xFF255EFB),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          ...services.map(
            (service) => _serviceRow(service),
          ),
        ],
      ),
    );
  }

  Widget _serviceRow(Map<String, dynamic> service) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: const Color(0xFFEEF4FF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              service['icon'],
              size: 17,
              color: const Color(0xFF2563EB),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              service['name'],
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            service['count'],
            style: const TextStyle(
              color: Color(0xFF2563EB),
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 42,
            child: Text(
              '(${service['percentage']})',
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 8,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _recentActivity() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Activity',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextButton(
                onPressed: () {
                  _showMessage('Opening all activities');
                },
                child: const Text(
                  'View All',
                  style: TextStyle(
                    color: Color(0xFF255EFB),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          ...recentActivities.map(
            (activity) => ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF4FF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.check_circle_outline,
                  size: 18,
                  color: Color(0xFF2563EB),
                ),
              ),
              title: Text(
                activity['title']!,
                style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(
                activity['subtitle']!,
                style: const TextStyle(
                  fontSize: 8,
                  color: Colors.black54,
                ),
              ),
              trailing: Text(
                activity['time']!,
                style: const TextStyle(
                  fontSize: 8,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
        ],
      ),
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
                  onTap: () => _onBottomNavigationTap(index),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          items[index]['icon'] as IconData,
                          size: 24,
                          color: selected
                              ? const Color(0xFF386BF6)
                              : Colors.black,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          items[index]['label'] as String,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            color: selected
                                ? const Color(0xFF386BF6)
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

class BookingChartPainter extends CustomPainter {
  final List<int> values;

  BookingChartPainter(this.values);

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = Colors.black.withOpacity(0.15)
      ..strokeWidth = 1;

    final linePaint = Paint()
      ..color = const Color(0xFF8979FF)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final pointPaint = Paint()
      ..color = const Color(0xFF8979FF)
      ..style = PaintingStyle.fill;

    const maxValue = 250.0;

    for (int i = 0; i < 6; i++) {
      final y = size.height * i / 5;
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        gridPaint,
      );
    }

    final path = Path();

    for (int i = 0; i < values.length; i++) {
      final x = values.length == 1
          ? size.width / 2
          : size.width * i / (values.length - 1);

      final y = size.height -
          (values[i] / maxValue) * size.height;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }

      canvas.drawCircle(
        Offset(x, y),
        4,
        pointPaint,
      );
    }

    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant BookingChartPainter oldDelegate) {
    return oldDelegate.values != values;
  }
}
