
import 'package:flutter/material.dart';

class MechanicDetails extends StatefulWidget {
  const MechanicDetails({super.key});

  @override
  State<MechanicDetails> createState() => _MechanicDetailsState();
}

class _MechanicDetailsState extends State<MechanicDetails> {
  final List<String> services = [
    'Battery Jumpstart',
    'Tyre Repair',
    'Oil Change',
    'Engine Repair',
  ];

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
        centerTitle: true,
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
          'Mechanic Details',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showMessage('More options');
            },
            icon: const Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 30),
          child: Column(
            children: [
              _mechanicHeader(),

              const SizedBox(height: 15),

              _actionButtons(),

              const SizedBox(height: 15),

              _aboutMechanic(),

              const SizedBox(height: 15),

              _services(),

              const SizedBox(height: 25),

              _requestButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mechanicHeader() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFCBFFF8),
        borderRadius: BorderRadius.circular(23),
        border: Border.all(
          color: const Color(0xFFD9D9D9),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 105,
            height: 105,
            decoration: BoxDecoration(
              color: const Color(0xFFE0EAFF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.person,
              size: 65,
              color: Color(0xFF2563EB),
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            'Rahul Kumar',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 8),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Text(
              'Available',
              style: TextStyle(
                color: Color(0xFF00711C),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.star,
                color: Colors.orange,
                size: 22,
              ),
              const SizedBox(width: 5),
              const Text(
                '4.8',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                '(120 Reviews)',
                style: TextStyle(
                  color: Colors.black.withValues(alpha: 0.45),
                  fontSize: 16,
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _infoItem(
                Icons.location_on_outlined,
                '7.2 Km',
                'away',
              ),
              _infoItem(
                Icons.access_time,
                '15 min',
                'arrival',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoItem(
    IconData icon,
    String value,
    String label,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color(0xFF2563EB),
          size: 22,
        ),
        const SizedBox(width: 5),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.black.withValues(alpha: 0.45),
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _actionButtons() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(23),
        border: Border.all(
          color: const Color(0xFFD9D9D9),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _actionButton(
            icon: Icons.call,
            title: 'Call',
            onTap: () {
              showMessage('Calling Rahul Kumar');
            },
          ),
          _actionButton(
            icon: Icons.message_outlined,
            title: 'Message',
            onTap: () {
              showMessage('Opening message');
            },
          ),
          _actionButton(
            icon: Icons.directions,
            title: 'Directions',
            onTap: () {
              showMessage('Opening directions');
            },
          ),
          _actionButton(
            icon: Icons.share_outlined,
            title: 'Share',
            onTap: () {
              showMessage('Share mechanic details');
            },
          ),
        ],
      ),
    );
  }

  Widget _actionButton({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: const Color(0xFFEEF4FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF2563EB),
              size: 23,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF1F2937),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _aboutMechanic() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFF99E7FF),
        borderRadius: BorderRadius.circular(23),
        border: Border.all(
          color: const Color(0xFFD9D9D9),
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About Mechanic',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 15),
          Text(
            '7+ years of experience in two wheeler, car repair services. '
            'Expert in all type of road side assistance',
            style: TextStyle(
              color: Color(0xFF1F2937),
              fontSize: 15,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _services() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFDCFFCF),
        borderRadius: BorderRadius.circular(23),
        border: Border.all(
          color: const Color(0xFFD9D9D9),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Services',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 15),

          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: services.map((service) {
              return _serviceChip(service);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _serviceChip(String service) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.check_circle,
            size: 15,
            color: Color(0xFF00711C),
          ),
          const SizedBox(width: 5),
          Text(
            service,
            style: const TextStyle(
              color: Color(0xFF00711C),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _requestButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          onPressed: () {
            showMessage('Service request started');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF6B00),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Request Service',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
