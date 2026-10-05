
import 'package:flutter/material.dart';
import 'package:wrenchgo/find_mech.dart';
import 'package:wrenchgo/home.dart';
import 'package:wrenchgo/mechdetails.dart';
import 'package:wrenchgo/my_bookings.dart';
import 'package:wrenchgo/profile.dart';

class TrackMechanic extends StatefulWidget {
  const TrackMechanic({super.key});

  @override
  State<TrackMechanic> createState() => _TrackMechanicState();
}

class _TrackMechanicState extends State<TrackMechanic> {
  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
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
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Track Mechanic',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              showMessage('Opening support');
            },
            child: const Text(
              'Support',
              style: TextStyle(
                color: Color(0xFF2563EB),
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 30,
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),

              _statusCard(),

              const SizedBox(height: 15),

              _etaCard(),

              const SizedBox(height: 15),

              _mechanicCard(),

              const SizedBox(height: 15),

              _bookingActions(),

              const SizedBox(height: 15),

              _safetyCard(),

              const SizedBox(height: 15),

              _bookingDetails(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _statusCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFCEECFF),
        borderRadius: BorderRadius.circular(23),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(
              Icons.directions_car,
              size: 32,
              color: Color(0xFF2563EB),
            ),
          ),

          const SizedBox(width: 15),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your mechanic is on the way',
                  style: TextStyle(
                    color: Color(0xFF2563EB),
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Relax! Your mechanic will reach you soon.',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _etaCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFF5E7FF),
        borderRadius: BorderRadius.circular(23),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(
              Icons.access_time,
              size: 30,
              color: Color(0xFF6C5CE7),
            ),
          ),

          const SizedBox(width: 15),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ETA',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '18 min',
                  style: TextStyle(
                    color: Color(0xFF2563EB),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '(4.2 km away)',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          const Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Arriving By',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 6),
              Text(
                '12:48 PM',
                style: TextStyle(
                  color: Color(0xFF6C5CE7),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _mechanicCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFBCFFDD),
        borderRadius: BorderRadius.circular(23),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 75,
            height: 75,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.person,
              size: 50,
              color: Color(0xFF2563EB),
            ),
          ),

          const SizedBox(width: 15),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rahul Kumar',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 18,
                      color: Colors.orange,
                    ),
                    SizedBox(width: 5),
                    Text(
                      '4.8 (120)',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.workspace_premium,
                      size: 18,
                      color: Color(0xFF2563EB),
                    ),
                    SizedBox(width: 5),
                    Text(
                      '8+ years Experienced',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bookingActions() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFDE2E2),
        borderRadius: BorderRadius.circular(23),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _actionButton(
                  icon: Icons.call,
                  text: 'Call',
                  color: const Color(0xFF33A852),
                  onTap: () {
                    showMessage('Calling Rahul Kumar');
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _actionButton(
                  icon: Icons.location_on,
                  text: 'Share Location',
                  color: const Color(0xFF386BF6),
                  onTap: () {
                    showMessage('Sharing location');
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: _actionButton(
                  icon: Icons.chat,
                  text: 'Chat',
                  color: const Color(0xFF386BF6),
                  onTap: () {
                    showMessage('Opening chat');
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _actionButton(
                  icon: Icons.cancel_outlined,
                  text: 'Cancel Booking',
                  color: Colors.red,
                  onTap: () {
                    _showCancelDialog();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _actionButton({
    required IconData icon,
    required String text,
    required Color color,
    required VoidCallback onTap,
  }) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(
        icon,
        color: color,
        size: 18,
      ),
      label: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
      ),
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        side: BorderSide(
          color: color,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 8,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(23),
        ),
      ),
    );
  }

  Widget _safetyCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFDDFAFF),
        borderRadius: BorderRadius.circular(23),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.shield_outlined,
            color: Color(0xFF2563EB),
            size: 35,
          ),

          SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Safety First',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Your safety is our priority. '
                  'All our mechanics are verified.',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bookingDetails() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE8B8),
        borderRadius: BorderRadius.circular(23),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),
      child: const Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Booking ID',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Service',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
              ),
              Text(
                'Amount',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                ),
              ),
            ],
          ),

          SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: Text(
                  'WG17563',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Tyre Puncture',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                '₹150.00',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bottomNavigationBar() {
    return BottomAppBar(
      color: Colors.white,
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _bottomItem(
              Icons.home_outlined,
              'Home',
              () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
              },
            ),
            _bottomItem(
              Icons.search,
              'Search',
              () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>FindMechanic()));
              },
            ),
            _bottomItem(
              Icons.receipt_long_outlined,
              'Bookings',
              () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MyBookings()));
              },
            ),
            _bottomItem(
              Icons.person_outline,
              'Profile',
              () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottomItem(
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: const Color(0xFF2563EB),
            size: 24,
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  void _showCancelDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Cancel Booking?'),
          content: const Text(
            'Are you sure you want to cancel this booking?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                showMessage('Booking cancelled');
              },
              child: const Text(
                'Yes, Cancel',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
