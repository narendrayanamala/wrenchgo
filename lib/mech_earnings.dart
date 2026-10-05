
import 'package:flutter/material.dart';
import 'package:wrenchgo/mech_booking_history.dart';
import 'package:wrenchgo/mech_dash.dart';
import 'package:wrenchgo/mech_profile.dart';
import 'package:wrenchgo/service_request.dart';

class MechanicEarnings extends StatefulWidget {
  const MechanicEarnings({super.key});

  @override
  State<MechanicEarnings> createState() => _MechanicEarningsState();
}

class _MechanicEarningsState extends State<MechanicEarnings> {
  int selectedIndex = 3;
  String selectedPeriod = 'This Month';

  final List<Map<String, dynamic>> transactions = [
    {
      'service': 'Engine Repair',
      'customer': 'Harsha',
      'date': '08 Aug 2026',
      'amount': 750,
      'status': 'Completed',
    },
    {
      'service': 'Battery Jumpstart',
      'customer': 'Sowmya',
      'date': '07 Aug 2026',
      'amount': 350,
      'status': 'Completed',
    },
    {
      'service': 'Tyre Puncture',
      'customer': 'Narendra',
      'date': '06 Aug 2026',
      'amount': 150,
      'status': 'Completed',
    },
    {
      'service': 'Oil Change',
      'customer': 'Ravi Kumar',
      'date': '05 Aug 2026',
      'amount': 450,
      'status': 'Completed',
    },
  ];

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget _statCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFE2E8F0),
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 27,
            ),
            const SizedBox(height: 7),
            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
                color: Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _earningRow({
    required String title,
    required String amount,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: const Color(0xFFEAF0FF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF386BF6),
              size: 21,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            amount,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _transactionCard(Map<String, dynamic> transaction) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFEAF0FF),
              borderRadius: BorderRadius.circular(11),
            ),
            child: const Icon(
              Icons.arrow_downward,
              color: Color(0xFF2D824C),
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction['service'],
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  transaction['customer'],
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  transaction['date'],
                  style: const TextStyle(
                    fontSize: 9,
                    color: Color(0xFF94A3B8),
                  ),
                ),
              ],
            ),
          ),
          Text(
            '+ ₹${transaction['amount']}',
            style: const TextStyle(
              color: Color(0xFF2D824C),
              fontSize: 13,
              fontWeight: FontWeight.w700,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF4FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEEF4FF),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'My Earnings',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Total earnings
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF386BF6),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.account_balance_wallet_outlined,
                          color: Colors.white,
                          size: 25,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Total Earnings',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Text(
                      '₹26,360',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '+16% compared to last month',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // Statistics
              Row(
                children: [
                  _statCard(
                    title: 'This Month',
                    value: '₹26,360',
                    icon: Icons.calendar_month_outlined,
                    color: const Color(0xFF2563EB),
                  ),
                  const SizedBox(width: 10),
                  _statCard(
                    title: 'Completed Jobs',
                    value: '120',
                    icon: Icons.check_circle_outline,
                    color: const Color(0xFF2D824C),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Row(
                children: [
                  _statCard(
                    title: 'Pending',
                    value: '₹2,450',
                    icon: Icons.pending_outlined,
                    color: const Color(0xFF986F15),
                  ),
                  const SizedBox(width: 10),
                  _statCard(
                    title: 'Avg. Per Job',
                    value: '₹470',
                    icon: Icons.trending_up,
                    color: const Color(0xFF8B5CF6),
                  ),
                ],
              ),

              const SizedBox(height: 22),

              // Period
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Earnings Overview',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  DropdownButton<String>(
                    value: selectedPeriod,
                    underline: const SizedBox(),
                    items: const [
                      DropdownMenuItem(
                        value: 'This Month',
                        child: Text('This Month'),
                      ),
                      DropdownMenuItem(
                        value: 'Last Month',
                        child: Text('Last Month'),
                      ),
                      DropdownMenuItem(
                        value: 'This Year',
                        child: Text('This Year'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value == null) return;

                      setState(() {
                        selectedPeriod = value;
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Earnings breakdown
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFFE2E8F0),
                  ),
                ),
                child: Column(
                  children: [
                    _earningRow(
                      title: 'Service Charges',
                      amount: '₹22,800',
                      icon: Icons.build_outlined,
                    ),
                    const Divider(),
                    _earningRow(
                      title: 'Roadside Assistance',
                      amount: '₹2,560',
                      icon: Icons.support_agent,
                    ),
                    const Divider(),
                    _earningRow(
                      title: 'Towing Charges',
                      amount: '₹1,000',
                      icon: Icons.local_shipping_outlined,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              const Text(
                'Recent Transactions',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 12),

              ...transactions.map(_transactionCard),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }
}
