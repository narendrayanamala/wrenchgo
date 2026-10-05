
import 'package:flutter/material.dart';
import 'package:wrenchgo/admin_dash.dart';
import 'package:wrenchgo/manage_booking.dart';
import 'package:wrenchgo/manage_users.dart';
import 'package:wrenchgo/manage_verification.dart';
import 'package:wrenchgo/reports_analytics.dart';

class ManageMechanics extends StatefulWidget {
  const ManageMechanics({super.key});

  @override
  State<ManageMechanics> createState() => _ManageMechanicsState();
}

class _ManageMechanicsState extends State<ManageMechanics> {
  int selectedFilter = 0;
  int selectedPage = 1;

  final TextEditingController searchController = TextEditingController();

  final List<String> filters = [
    'All (48)',
    'Active (42)',
    'Inactive',
    'Blocked (0)',
  ];

  final List<Map<String, dynamic>> mechanics = [
    {
      'name': 'Ravi kumar Mechanic',
      'phone': '91+ 9876543210',
      'location': 'MG Road, Vijayawada, AP',
      'services': 'Engine Repair, Oil Change, Battery',
      'joined': 'Joined on 08 Aug 2026',
      'status': 'Active',
      'rating': '4.8',
      'reviews': '(126)',
      'icon': Icons.engineering_outlined,
    },
    {
      'name': 'Idhaya Ram Motors',
      'phone': '91+ 9341237092',
      'location': 'Benz Circle, Vijayawada, AP',
      'services': 'Tyre Service, Wheel Balance',
      'joined': 'Joined on 04 Aug 2026',
      'status': 'Active',
      'rating': '4.5',
      'reviews': '(94)',
      'icon': Icons.build_circle_outlined,
    },
    {
      'name': 'Sharma Auto Works',
      'phone': '91+ 8328470572',
      'location': 'Madhurawada, Visakhapatnam',
      'services': 'Towing Service, Jumpstart',
      'joined': 'Joined on 26 Aug 2026',
      'status': 'Inactive',
      'rating': '3.9',
      'reviews': '(45)',
      'icon': Icons.car_repair,
    },
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  List<Map<String, dynamic>> get filteredMechanics {
    List<Map<String, dynamic>> result = mechanics;

    if (selectedFilter == 1) {
      result = result
          .where((mechanic) => mechanic['status'] == 'Active')
          .toList();
    } else if (selectedFilter == 2) {
      result = result
          .where((mechanic) => mechanic['status'] == 'Inactive')
          .toList();
    } else if (selectedFilter == 3) {
      result = result
          .where((mechanic) => mechanic['status'] == 'Blocked')
          .toList();
    }

    final search = searchController.text.trim().toLowerCase();

    if (search.isNotEmpty) {
      result = result.where((mechanic) {
        return mechanic['name']
                .toString()
                .toLowerCase()
                .contains(search) ||
            mechanic['phone']
                .toString()
                .toLowerCase()
                .contains(search) ||
            mechanic['services']
                .toString()
                .toLowerCase()
                .contains(search);
      }).toList();
    }

    return result;
  }

  void _showMechanicDetails(Map<String, dynamic> mechanic) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(mechanic['name']),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _detailRow('Phone', mechanic['phone']),
              _detailRow('Location', mechanic['location']),
              _detailRow('Services', mechanic['services']),
              _detailRow('Rating', '${mechanic['rating']} ${mechanic['reviews']}'),
              _detailRow('Status', mechanic['status']),
              _detailRow('Joined', mechanic['joined']),
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

  Widget _detailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 70,
            child: Text(
              title,
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

  void _toggleStatus(Map<String, dynamic> mechanic) {
    setState(() {
      mechanic['status'] =
          mechanic['status'] == 'Active' ? 'Inactive' : 'Active';
    });

    _showMessage(
      '${mechanic['name']} is now ${mechanic['status']}',
    );
  }

  void _callMechanic(Map<String, dynamic> mechanic) {
    _showMessage(
      'Calling ${mechanic['name']}',
    );
  }

  void _blockMechanic(Map<String, dynamic> mechanic) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Block Mechanic'),
          content: Text(
            'Are you sure you want to block ${mechanic['name']}?',
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
                  mechanic['status'] = 'Blocked';
                });

                _showMessage('Mechanic blocked');
              },
              child: const Text('Block'),
            ),
          ],
        );
      },
    );
  }

  void _addNewMechanic() {
    _showMessage('Add New Mechanic selected');
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
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 20),
                child: Column(
                  children: [
                    _summaryCard(),
                    const SizedBox(height: 14),
                    _searchBar(),
                    const SizedBox(height: 14),
                    _filterTabs(),
                    const SizedBox(height: 14),
                    _mechanicList(),
                    const SizedBox(height: 14),
                    _pagination(),
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
              'Manage Mechanics',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _summaryCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF3E6DED),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.engineering_outlined,
              color: Colors.white,
              size: 34,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Total Mechanics',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  '188',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Active: 102',
                      style: TextStyle(
                        color: Color(0xFFA9E68A),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 14),
                    Text(
                      'Inactive: 86',
                      style: TextStyle(
                        color: Color(0xFFF09898),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ElevatedButton.icon(
            onPressed: _addNewMechanic,
            icon: const Icon(
              Icons.add,
              size: 18,
            ),
            label: const Text(
              'Add New\nMechanic',
              textAlign: TextAlign.center,
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF879EEE),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
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

  Widget _searchBar() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.75),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: searchController,
        onChanged: (_) {
          setState(() {});
        },
        decoration: InputDecoration(
          hintText:
              'Search mechanic by name, phone, service......',
          hintStyle: const TextStyle(
            color: Color(0xFF64748B),
            fontSize: 11,
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: Color(0xFF64748B),
          ),
          suffixIcon: searchController.text.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    searchController.clear();
                    setState(() {});
                  },
                  icon: const Icon(Icons.clear),
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
        ),
      ),
    );
  }

  Widget _filterTabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          filters.length,
          (index) {
            final selected = selectedFilter == index;

            return Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                onTap: () {
                  setState(() {
                    selectedFilter = index;
                    selectedPage = 1;
                  });
                },
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 13,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: selected
                        ? const Color(0xFF2563EB)
                        : Colors.white,
                    border: Border.all(
                      color: selected
                          ? const Color(0xFF2563EB)
                          : Colors.black26,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    filters[index],
                    style: TextStyle(
                      color: selected
                          ? Colors.white
                          : Colors.black,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
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

  Widget _mechanicList() {
    final list = filteredMechanics;

    if (list.isEmpty) {
      return _emptyState();
    }

    return Column(
      children: list.map((mechanic) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _mechanicCard(mechanic),
        );
      }).toList(),
    );
  }

  Widget _mechanicCard(Map<String, dynamic> mechanic) {
    final bool isActive = mechanic['status'] == 'Active';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _mechanicIcon(mechanic['icon']),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            mechanic['name'],
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        _statusBadge(
                          mechanic['status'],
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    _infoRow(
                      Icons.phone_outlined,
                      mechanic['phone'],
                    ),
                    const SizedBox(height: 4),
                    _infoRow(
                      Icons.location_on_outlined,
                      mechanic['location'],
                    ),
                    const SizedBox(height: 4),
                    _infoRow(
                      Icons.build_outlined,
                      mechanic['services'],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 15,
                          color: Colors.amber,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          mechanic['rating'],
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 3),
                        Text(
                          mechanic['reviews'],
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 7),
          Row(
            children: [
              const Icon(
                Icons.calendar_today_outlined,
                size: 13,
                color: Colors.black54,
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  mechanic['joined'],
                  style: const TextStyle(
                    fontSize: 9,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _actionButton(
                label: 'View Details',
                onPressed: () {
                  _showMechanicDetails(mechanic);
                },
              ),
              _actionButton(
                label: 'Call',
                onPressed: () {
                  _callMechanic(mechanic);
                },
              ),
              _actionButton(
                label: isActive ? 'Deactivate' : 'Activate',
                onPressed: () {
                  _toggleStatus(mechanic);
                },
              ),
              if (mechanic['status'] != 'Blocked')
                _actionButton(
                  label: 'Block',
                  danger: true,
                  onPressed: () {
                    _blockMechanic(mechanic);
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _mechanicIcon(IconData icon) {
    return Container(
      width: 68,
      height: 68,
      decoration: BoxDecoration(
        color: const Color(0xFFEEF4FF),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(
        icon,
        size: 34,
        color: const Color(0xFF2563EB),
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
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 9,
            ),
          ),
        ),
      ],
    );
  }

  Widget _statusBadge(String status) {
    final bool active = status == 'Active';

    Color background;
    Color foreground;

    if (status == 'Blocked') {
      background = const Color(0xFFFFD4D4);
      foreground = Colors.red.shade800;
    } else if (active) {
      background = const Color(0xFFD6ECC7);
      foreground = const Color(0xFF2D824C);
    } else {
      background = const Color(0xFFF1A2A2);
      foreground = const Color(0xFF8B1414);
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: foreground,
          fontSize: 9,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _actionButton({
    required String label,
    required VoidCallback onPressed,
    bool danger = false,
  }) {
    return SizedBox(
      height: 30,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: danger
              ? Colors.red
              : const Color(0xFF0044FF),
          backgroundColor: danger
              ? const Color(0xFFFFF5F5)
              : const Color(0xFFF9F8FF),
          side: BorderSide(
            color: danger
                ? Colors.red
                : const Color(0xFF220AF7),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 11,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 9,
          ),
        ),
      ),
    );
  }

  Widget _emptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 45,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.engineering_outlined,
            size: 45,
            color: Colors.grey,
          ),
          SizedBox(height: 10),
          Text(
            'No mechanics found',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Try another filter or search term.',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _pagination() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 12,
      ),
      color: const Color(0xFFF2EEEE),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'Showing 1 to 5 to 48 Mechanics',
              style: TextStyle(
                fontSize: 10,
              ),
            ),
          ),
          IconButton(
            onPressed: selectedPage > 1
                ? () {
                    setState(() {
                      selectedPage--;
                    });
                  }
                : null,
            icon: const Icon(
              Icons.chevron_left,
              size: 20,
            ),
          ),
          _pageButton(1),
          _pageButton(2),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 3),
            child: Text(
              '...',
              style: TextStyle(fontSize: 11),
            ),
          ),
          _pageButton(10),
          IconButton(
            onPressed: selectedPage < 10
                ? () {
                    setState(() {
                      selectedPage++;
                    });
                  }
                : null,
            icon: const Icon(
              Icons.chevron_right,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _pageButton(int page) {
    final selected = selectedPage == page;

    return InkWell(
      onTap: () {
        setState(() {
          selectedPage = page;
        });
      },
      child: Container(
        width: 28,
        height: 26,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFF386BF6)
              : Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          '$page',
          style: TextStyle(
            fontSize: 10,
            color: selected ? Colors.white : Colors.black,
          ),
        ),
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
              final selected = index == 2;

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
    }
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
                          color: selected
                              ? const Color(0xFF386BF6)
                              : Colors.black,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          items[index]['label'] as String,
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
