
import 'package:flutter/material.dart';
import 'package:wrenchgo/admin_dash.dart';
import 'package:wrenchgo/admin_login.dart';
import 'package:wrenchgo/manage_booking.dart';
import 'package:wrenchgo/manage_mechanics.dart';
import 'package:wrenchgo/manage_users.dart';
import 'package:wrenchgo/reports_analytics.dart';

class ManageVerification extends StatefulWidget {
  const ManageVerification({super.key});

  @override
  State<ManageVerification> createState() => _ManageVerificationState();
}

class _ManageVerificationState extends State<ManageVerification> {
  int selectedTab = 0;
  bool isProcessed = false;
  String verificationStatus = 'Pending';

  final List<String> tabs = [
    'Pending (12)',
    'Approved (64)',
    'Rejected (8)',
  ];

  final List<String> services = [
    'Engine Repair',
    'Oil Change',
    'Battery Service',
    'Back Repair',
    '+2',
  ];

  final List<Map<String, String>> documents = [
    {
      'title': 'Aadhar Card',
      'status': 'Verified',
    },
    {
      'title': 'Pan Card',
      'status': 'Verified',
    },
    {
      'title': 'Driving License',
      'status': 'Verified',
    },
    {
      'title': 'Experience Certificate',
      'status': 'Verified',
    },
  ];

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _approveMechanic() {
    setState(() {
      verificationStatus = 'Approved';
      isProcessed = true;
    });

    _showMessage('Mechanic verification approved');
  }

  void _rejectMechanic() {
    showDialog(
      context: context,
      builder: (context) {
        final controller = TextEditingController();

        return AlertDialog(
          title: const Text('Reject Verification'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Please provide a reason for rejecting this mechanic.',
              ),
              const SizedBox(height: 12),
              TextField(
                controller: controller,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Rejection reason',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);

                setState(() {
                  verificationStatus = 'Rejected';
                  isProcessed = true;
                });

                _showMessage('Mechanic verification rejected');
              },
              child: const Text('Reject'),
            ),
          ],
        );
      },
    );
  }

  void _viewAllDocuments() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'All Documents',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 14),
                ...documents.map(
                  (document) => ListTile(
                    leading: const Icon(
                      Icons.description_outlined,
                      color: Color(0xFF2563EB),
                    ),
                    title: Text(document['title']!),
                    trailing: Text(
                      document['status']!,
                      style: const TextStyle(
                        color: Color(0xFF287E0D),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _reviewDocuments() {
    _viewAllDocuments();
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
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 24),
                child: Column(
                  children: [
                    _verificationSummary(),
                    const SizedBox(height: 14),
                    _tabs(),
                    const SizedBox(height: 14),
                    _mechanicCard(),
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back),
          ),
          const Expanded(
            child: Text(
              'Manage Verification',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
           IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminLogin()));
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.red,
              size: 28,
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _verificationSummary() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF879EEE),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF93C0EA),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.verified_user_outlined,
              color: Colors.white,
              size: 35,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pending Verification',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  '12',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Mechanics required your action',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton.icon(
            onPressed: _reviewDocuments,
            icon: const Icon(
              Icons.fact_check_outlined,
              size: 18,
            ),
            label: const Text(
              'Review All\nDocuments',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF0786FD),
              padding: const EdgeInsets.symmetric(
                horizontal: 9,
                vertical: 9,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          tabs.length,
          (index) {
            final selected = selectedTab == index;

            return Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                onTap: () {
                  setState(() {
                    selectedTab = index;
                  });
                },
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: selected
                        ? const Color(0xFF2563EB)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: selected
                          ? const Color(0xFF2563EB)
                          : Colors.black26,
                    ),
                  ),
                  child: Text(
                    tabs[index],
                    style: TextStyle(
                      color: selected
                          ? Colors.white
                          : Colors.black,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _mechanicCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),
      child: Column(
        children: [
          _mechanicHeader(),
          _mechanicStats(),
          _servicesSection(),
          _documentsSection(),
          _additionalInformation(),
          _warningNote(),
          _actionButtons(),
        ],
      ),
    );
  }

  Widget _mechanicHeader() {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 78,
            height: 78,
            decoration: BoxDecoration(
              color: const Color(0xFFEEF4FF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.engineering_outlined,
              size: 42,
              color: Color(0xFF2563EB),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Ravi kumar Mechanic',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    _newRegistrationBadge(),
                  ],
                ),
                const SizedBox(height: 8),
                _infoRow(
                  Icons.phone_outlined,
                  '91+ 9876543210',
                ),
                const SizedBox(height: 5),
                _infoRow(
                  Icons.email_outlined,
                  'ravikumar23@gmail.com',
                ),
                const SizedBox(height: 5),
                _infoRow(
                  Icons.location_on_outlined,
                  'MG Road, Vijayawada, AP',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _newRegistrationBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF6EFC5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Text(
        'New Registration',
        style: TextStyle(
          color: Color(0xFF876205),
          fontSize: 9,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14,
          color: Colors.black54,
        ),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 9,
            ),
          ),
        ),
      ],
    );
  }

  Widget _mechanicStats() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 12,
      ),
      color: const Color(0x89CBDEEE),
      child: Row(
        children: [
          _statItem(
            Icons.workspace_premium_outlined,
            '5+',
            'Years Experience',
          ),
          _verticalDivider(),
          _statItem(
            Icons.build_outlined,
            'Engine Repair',
            'Specialization',
          ),
          _verticalDivider(),
          _statItem(
            Icons.star_outline,
            '4.8',
            'Avg. Rating',
          ),
          _verticalDivider(),
          _statItem(
            Icons.check_circle_outline,
            '128',
            'Jobs completed',
          ),
        ],
      ),
    );
  }

  Widget _statItem(
    IconData icon,
    String value,
    String label,
  ) {
    return Expanded(
      child: Column(
        children: [
          Icon(
            icon,
            size: 20,
            color: const Color(0xFF2563EB),
          ),
          const SizedBox(height: 3),
          Text(
            value,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _verticalDivider() {
    return Container(
      width: 1,
      height: 40,
      color: Colors.black26,
    );
  }

  Widget _servicesSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 14, 12, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Services Offered',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 7,
            runSpacing: 7,
            children: services.map(
              (service) {
                final isMore = service == '+2';

                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0x51C5E3F2),
                    border: Border.all(
                      color: const Color(0x608E8383),
                    ),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Text(
                    service,
                    style: TextStyle(
                      color: isMore
                          ? const Color(0xFF096ABA)
                          : Colors.black,
                      fontSize: 9,
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }

  Widget _documentsSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Documents',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              TextButton(
                onPressed: _viewAllDocuments,
                child: const Text(
                  'View All',
                  style: TextStyle(
                    color: Color(0xFF0A3BBF),
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: documents.length,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.82,
            ),
            itemBuilder: (context, index) {
              return _documentCard(
                documents[index],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _documentCard(Map<String, String> document) {
    return Container(
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBFB),
        border: Border.all(
          color: const Color(0xFFF5F5F5),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.description_outlined,
            size: 34,
            color: Color(0xFF2563EB),
          ),
          const SizedBox(height: 5),
          Text(
            document['title']!,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 8,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            document['status']!,
            style: const TextStyle(
              color: Color(0xFF287E0D),
              fontSize: 8,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _additionalInformation() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Additional Information',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    _detailItem('Gender', 'Male'),
                    _detailItem(
                      'Date of Birth',
                      '04 Oct 1994',
                    ),
                    _detailItem(
                      'Languages',
                      'Telugu, Hindi, English',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    _detailItem(
                      'Availability',
                      'Mon - Sun (9AM - 8PM)',
                    ),
                    _detailItem(
                      'Address',
                      'MG Road, Vijayawada,\nAndhra Pradesh - 520010',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _detailItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 70,
            child: Text(
              '$title:',
              style: const TextStyle(
                fontSize: 9,
                color: Colors.black54,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _warningNote() {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        color: const Color(0x68F2ECC6),
        border: Border.all(
          color: const Color(0xFF7F770C),
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            size: 17,
            color: Color(0xFF6B6107),
          ),
          SizedBox(width: 7),
          Expanded(
            child: Text(
              'Please verify all documents and information carefully before taking action.',
              style: TextStyle(
                color: Color(0xFF888807),
                fontSize: 8,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButtons() {
    if (isProcessed) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: verificationStatus == 'Approved'
                ? const Color(0xFFD8E9CF)
                : const Color(0xFFFBE2E2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            'Verification ${verificationStatus.toLowerCase()}',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: verificationStatus == 'Approved'
                  ? const Color(0xFF238E08)
                  : const Color(0xFFB70808),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: _rejectMechanic,
              icon: const Icon(
                Icons.close,
                size: 16,
              ),
              label: const Text('Reject'),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFFB70808),
                backgroundColor: const Color(0xD3FBE2E2),
                side: const BorderSide(
                  color: Color(0xFFAC6D6D),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 11,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: _approveMechanic,
              icon: const Icon(
                Icons.check,
                size: 16,
              ),
              label: const Text('Approve'),
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color(0xFF238E08),
                backgroundColor: const Color(0xB2D8E9CF),
                side: const BorderSide(
                  color: Color(0xFF9DAE83),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 11,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomNavigationBar() {
    const items = [
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
              return Expanded(
                child: InkWell(
                  onTap: () {
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
    };
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          items[index]['icon'] as IconData,
                          size: 24,
                          color: index == 2
                              ? const Color(0xFF386BF6)
                              : Colors.black,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          items[index]['label'] as String,
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            color: index == 2
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
