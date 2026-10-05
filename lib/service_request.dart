
import 'package:flutter/material.dart';

class ServiceRequest extends StatefulWidget {
  const ServiceRequest({super.key});

  @override
  State<ServiceRequest> createState() => _ServiceRequestState();
}

class _ServiceRequestState extends State<ServiceRequest> {
  bool requestHandled = false;

  void acceptRequest() {
    setState(() {
      requestHandled = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Service request accepted.'),
      ),
    );
  }

  void rejectRequest() {
    setState(() {
      requestHandled = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Service request rejected.'),
      ),
    );
  }

  void viewLocation() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Opening customer location...'),
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
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'Service Request',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: requestHandled
            ? _requestHandledView()
            : SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: _requestCard(),
              ),
      ),
    );
  }

  Widget _requestCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(23),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),
      child: Column(
        children: [
          _requestIcon(),

          const SizedBox(height: 18),

          const Text(
            'New Service Request',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'You have received a new service request',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: Colors.black54,
            ),
          ),

          const SizedBox(height: 30),

          _detailSection(
            icon: Icons.person_outline,
            title: 'Customer',
            value: 'Harsha',
          ),

          _detailSection(
            icon: Icons.location_on_outlined,
            title: 'Location',
            value: 'Cross roads, Vijayawada',
            trailing: TextButton(
              onPressed: viewLocation,
              child: const Text('2.5 km'),
            ),
          ),

          _detailSection(
            icon: Icons.build_outlined,
            title: 'Service',
            value: 'Tyre Puncture',
          ),

          _detailSection(
            icon: Icons.currency_rupee,
            title: 'Estimated Amount',
            value: '₹350',
            trailing: const Text(
              'Cash',
              style: TextStyle(
                color: Color(0xFFFF6B00),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          const SizedBox(height: 24),

          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: acceptRequest,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 13,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Accept',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: OutlinedButton(
                  onPressed: rejectRequest,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFFFF6B00),
                    padding: const EdgeInsets.symmetric(
                      vertical: 13,
                    ),
                    side: const BorderSide(
                      color: Color(0xFFFF6B00),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Reject',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _requestIcon() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: const Color(0xFFE5FFE4),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.car_repair_outlined,
        size: 58,
        color: Color(0xFF2563EB),
      ),
    );
  }

  Widget _detailSection({
    required IconData icon,
    required String title,
    required String value,
    Widget? trailing,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F0FF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF2563EB),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          if (trailing != null) trailing,
        ],
      ),
    );
  }

  Widget _requestHandledView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline,
              size: 80,
              color: Colors.green.shade600,
            ),
            const SizedBox(height: 20),
            const Text(
              'Request Handled',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'The service request has been processed.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Back to Dashboard'),
            ),
          ],
        ),
      ),
    );
  }
}
